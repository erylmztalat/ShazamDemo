//
//  ShazamViewController.swift
//  App
//
//  Created by talate on 24.10.2023.
//

import UIKit

class ShazamViewController: UIViewController {
    
    private var shazamView: ShazamView
    private var viewModel: ShazamViewModel

    init(shazamView: ShazamView, viewModel: ShazamViewModel) {
        self.shazamView = shazamView
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Failed to set up audio session")
        setupView()
    }
    
    private func setupView() {
        self.view.setGradientBackground(from: .primaryLight, to: .primary)
        
        self.view.addSubview(shazamView)
        
        shazamView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shazamView.topAnchor.constraint(equalTo: view.topAnchor),
            shazamView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shazamView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shazamView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        shazamView.delegate = self
    }
}

extension ShazamViewController: ShazamViewProtocol {
    func didReceiveAudio(with base64data: String) {
        viewModel.fetch(base64AudioData: base64data) { [weak self] result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async { [weak self] in
                    let songDetailVC = SongDetailViewController(songDetailView: SongDetailView(), shazamResponse: response)
                    self?.present(songDetailVC, animated: true)
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}
