//
//  ViewProtocol.swift
//  App
//
//  Created by talate on 15.10.2023.
//

import UIKit

protocol ViewProtocol: AnyObject {
    func setupSubviews()
    func setupConstraints()
    func setupActions()
}

extension ViewProtocol where Self: UIView {
    func setupUI() {
        setupSubviews()
        setupConstraints()
        setupActions()
    }
}
