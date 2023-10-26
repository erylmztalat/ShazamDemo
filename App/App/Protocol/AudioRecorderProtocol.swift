//
//  AudioProtocol.swift
//  App
//
//  Created by talate on 19.10.2023.
//

import Foundation

protocol AudioRecorderProtocol {
    func startRecording(completion: @escaping (String?) -> Void)
    func stopRecording()
}

