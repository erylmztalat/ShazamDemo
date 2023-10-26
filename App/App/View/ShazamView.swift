//
//  ShazamView.swift
//  App
//
//  Created by talate on 3.10.2023.
//

import UIKit

protocol ShazamViewProtocol: AnyObject {
    func didReceiveAudio(with base64data: String)
}

class ShazamView: UIView {
    weak var delegate: ShazamViewProtocol?
        
    private let shazamLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = AppString.tapToShazam
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        return label
    }()
    
    private let shazamButton: ShazamButton = {
        let button = ShazamButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(Image.shazam, for: .normal)
        button.layer.cornerRadius = 100.0
        button.backgroundColor = .shazam
        button.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
        let imagePadding = 40.0
        button.imageEdgeInsets = UIEdgeInsets(top: imagePadding, left: imagePadding, bottom: imagePadding, right:imagePadding)
        button.addShadow()
        return button
    }()
    
    private let shazamActionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = AppString.listeningMusic
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        label.isHidden = true
        return label
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .shazam
        button.setTitle(AppString.cancel, for: .normal)
        button.layer.cornerRadius = 8.0
        button.addShadow()
        button.isHidden = true
        return button
    }()

    private var audioRecorder: AudioRecorderProtocol
    
    init(audioRecorder: AudioRecorderProtocol) {
        self.audioRecorder = audioRecorder
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func startShazam() {
        shazamButton.startListening()
    }
    
    @objc func cancelShazam() {
        shazamButton.cancelListening()
    }
    
    public func resetShazam() {
        shazamButton.cancelListening()
        stopRecording()
    }
    
    private func startRecording() {
        audioRecorder.startRecording { [weak self] data in
            self?.delegate?.didReceiveAudio(with: data ?? "")
        }
    }
    
    private func stopRecording() {
        audioRecorder.stopRecording()
    }
}

extension ShazamView: ViewProtocol {
    func setupSubviews() {
        addSubview(shazamLabel)
        shazamButton.delegate = self
        addSubview(shazamButton)
        addSubview(shazamActionLabel)
        addSubview(cancelButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            shazamButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            shazamButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            shazamButton.widthAnchor.constraint(equalToConstant: Dimen.shazamBtnWidthAnchor),
            shazamButton.heightAnchor.constraint(equalToConstant: Dimen.shazamBtnHeightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shazamLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            shazamLabel.bottomAnchor.constraint(equalTo: shazamButton.topAnchor, constant: Dimen.shazamLabelBottomAnchor),
            shazamLabel.widthAnchor.constraint(equalToConstant: Dimen.shazamLabelWidthAnchor),
            shazamLabel.heightAnchor.constraint(equalToConstant: Dimen.shazamLabelHeightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            shazamActionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            shazamActionLabel.topAnchor.constraint(equalTo: shazamButton.bottomAnchor, constant: Dimen.shazamActionLabelTopAnchor),
            shazamActionLabel.widthAnchor.constraint(equalToConstant: Dimen.shazamLabelWidthAnchor),
            shazamActionLabel.heightAnchor.constraint(equalToConstant: Dimen.shazamLabelHeightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: self.topAnchor, constant: Dimen.cancelBtnTopAnchor),
            cancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: Dimen.cancelBtnRightAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: Dimen.cancelBtnWidthAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: Dimen.cancelBtnHeightAnchor)
        ])
    }
    
    func setupActions() {
        shazamButton.addTarget(self, action: #selector(startShazam), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancelShazam), for: .touchUpInside)
    }
}

extension ShazamView: ShazamButtonProtocol {
    func shazamButtonDidClick(isListening: Bool) {
        if isListening {
            shazamLabel.isHidden = true
            shazamActionLabel.isHidden = false
            cancelButton.isHidden = false
            startRecording()
        }else {
            shazamLabel.isHidden = false
            shazamActionLabel.isHidden = true
            cancelButton.isHidden = true
            audioRecorder.stopRecording()
            stopRecording()
        }
    }
}
