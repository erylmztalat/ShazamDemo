//
//  AudioRecorder.swift
//  App
//
//  Created by talate on 19.10.2023.
//

import Foundation
import AVFoundation

class AudioRecorder: AudioRecorderProtocol {
    private var audioEngine: AVAudioEngine
    private var inputNode: AVAudioInputNode
    private var audioData = Data()
    
    init() {
        audioEngine = AVAudioEngine()
        inputNode = audioEngine.inputNode
    }
    
    func startRecording(completion: @escaping (String?) -> Void) {
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        let converter = AVAudioConverter(from: recordingFormat, to: setupAudioFormat())!
        
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { [weak self] (buffer, _) in
            guard let self = self else { return }
            
            let outputBuffer = AVAudioPCMBuffer(pcmFormat: converter.outputFormat, frameCapacity: buffer.frameCapacity)!
            var error: NSError?
            converter.convert(to: outputBuffer, error: &error, withInputFrom: { inNumPackets, outStatus in
                outStatus.pointee = .haveData
                return buffer
            })
            
            if let error = error {
                print("Conversion error: \(error)")
                return
            }
            
            let data = self.audioPCMBufferToData(outputBuffer)
            self.audioData.append(data)
            
            if audioData.count >= 500 * 1024 {
                audioData = audioData.prefix(500 * 1024) // Trim data to 500KB if it exceeds this size
                let base64String = audioData.base64EncodedString()
                completion(base64String)
                stopRecording()
            }
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("Could not start engine: \(error)")
            completion(nil)
        }
    }
    
    func stopRecording() {
        audioEngine.stop()
        inputNode.removeTap(onBus: 0)
    }
    
    private func stopAndPrepareData(completion: @escaping (String?) -> Void) {
        stopRecording()
        if audioData.count > 500 * 1024 {
            audioData = audioData.prefix(500 * 1024) // Trim data to 500KB if it exceeds this size
        }
        let base64String = audioData.base64EncodedString()
        completion(base64String)
    }
    
    private func setupAudioFormat() -> AVAudioFormat {
        // Set up the audio format 44100Hz, 1 channel, 16 bits
        let format = AVAudioFormat(commonFormat: .pcmFormatInt16, sampleRate: 44100, channels: 1, interleaved: true)! // mono
        return format
    }
    
    private func audioPCMBufferToData(_ buffer: AVAudioPCMBuffer) -> Data {
        let channelCount = 1  // given mono
        let bufferLength = buffer.frameCapacity * UInt32(channelCount) * 2 // since we're doing 16 bit samples
    
        let channels = UnsafeBufferPointer(start: buffer.int16ChannelData, count: Int(buffer.stride))
        let data = Data(bytes: channels[0], count: Int(bufferLength))
        
        return data
    }
}


