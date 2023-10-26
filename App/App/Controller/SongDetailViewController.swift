//
//  SongDetailViewController.swift
//  App
//
//  Created by talate on 26.10.2023.
//

import UIKit

class SongDetailViewController: UIViewController {
    
    private var songDetailView: SongDetailView
    private var shazamResponse: ShazamResponse

    init(songDetailView: SongDetailView, shazamResponse: ShazamResponse) {
        self.songDetailView = songDetailView
        self.shazamResponse = shazamResponse
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(songDetailView)
        
        songDetailView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            songDetailView.topAnchor.constraint(equalTo: view.topAnchor),
            songDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            songDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            songDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        songDetailView.bindView(with: shazamResponse.track)
    }
    
}
