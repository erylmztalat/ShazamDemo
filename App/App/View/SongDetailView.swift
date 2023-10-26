//
//  File.swift
//  App
//
//  Created by talate on 26.10.2023.
//

import UIKit

class SongDetailView: UIView {
    
    private let songDetailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
        
    private let songDetailTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 18.0, weight: .bold)
        return label
    }()
    
    private let songDetailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 15.0)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindView(with track: Track?) {
        guard let track = track else { return }
        
        if let url = URL(string: track.images?.background ?? "") {
            songDetailImageView.setImage(from: url)
        }
        
        songDetailTitleLabel.text = track.subtitle
        songDetailLabel.text = track.title
    }
}

extension SongDetailView: ViewProtocol {
    func setupSubviews() {
        addSubview(songDetailImageView)
        addSubview(songDetailTitleLabel)
        addSubview(songDetailLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            songDetailImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            songDetailImageView.topAnchor.constraint(equalTo: topAnchor),
            songDetailImageView.widthAnchor.constraint(equalTo: widthAnchor),
            songDetailImageView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
        NSLayoutConstraint.activate([
            songDetailTitleLabel.topAnchor.constraint(equalTo: songDetailImageView.bottomAnchor, constant: 80),
            songDetailTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            songDetailTitleLabel.heightAnchor.constraint(equalToConstant:20)
        ])
        
        NSLayoutConstraint.activate([
            songDetailLabel.topAnchor.constraint(equalTo: songDetailTitleLabel.bottomAnchor, constant: 5),
            songDetailLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            songDetailLabel.heightAnchor.constraint(equalToConstant:20)
        ])
    }
    
    func setupActions() {
        //No actions
    }
}
