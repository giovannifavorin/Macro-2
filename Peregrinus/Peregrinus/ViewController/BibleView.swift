//
//  BibleView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//

import UIKit

class BibleView: UIView {
    
    let titleLabel: TextComponent = {
        let label = TextComponent("No Verse Selected")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.setCustomFont(.textoNormal) // Using English naming
        label.numberOfLines = 0 // Suporta várias linhas
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(titleLabel)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Usando o safeAreaLayoutGuide para evitar a navigation bar
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}

