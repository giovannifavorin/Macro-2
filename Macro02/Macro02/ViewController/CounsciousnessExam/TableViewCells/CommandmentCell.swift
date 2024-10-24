//
//  CommandmentCell.swift
//  Macro02
//
//  Created by Victor Dantas on 24/10/24.
//

import UIKit

class CommandmentCell: UITableViewCell {
    
    static let reuseIdentifier = "CommandmentCell"
    
    // Título do Mandamento
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Descrição do Mandamento
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Método de configuração que recebe o título e a descrição
    func configure(withTitle title: String, description: String) {
        titleLabel.text = title
        descriptionLabel.text = description
        setupLayout()
    }
    
    // Configura o layout da célula
    private func setupLayout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            
            descriptionLabel.topAnchor.constraint(equalTo: centerYAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.75)
        ])
    }
}
