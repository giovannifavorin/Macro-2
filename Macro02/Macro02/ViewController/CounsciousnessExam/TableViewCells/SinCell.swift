//
//  SinCell.swift
//  Macro02
//
//  Created by Victor Dantas on 24/10/24.
//

import UIKit

class SinCell: UITableViewCell {
    
    static let reuseIdentifier = "SinCell"
    
    // Label para o texto do pecado
    let sinLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // UIView que será usada para adicionar margens internas
    let backgroundCardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // Propriedade customizada isSelected para controlar a aparência
    var isSinSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }

    // Método de configuração da célula
    func configure(with sin: String, isSelected: Bool) {
        sinLabel.text = sin
        self.isSinSelected = isSelected
        setupLayout()
        setupConstraints()
        updateAppearance() // Atualiza a aparência com base no estado atual
    }

    // Configura o layout da célula com um background view para margens
    private func setupLayout() {
        // Adiciona o backgroundCardView como uma subview
        contentView.addSubview(backgroundCardView)
        backgroundCardView.addSubview(sinLabel)
    }

    // Configura as constraints para o layout da célula
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Define margens (padding) ao redor do backgroundCardView
            backgroundCardView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: bounds.height * 0.05),
            backgroundCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: bounds.height * -0.05),
            
            // Define o posicionamento do texto (pecado)
            sinLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sinLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: bounds.width * 0.05),
            sinLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: bounds.width * -0.05),
        ])
    }
    
    // Atualiza a aparência da célula com base no estado de seleção
    private func updateAppearance() {
        if isSinSelected {
            backgroundCardView.backgroundColor = .lightGray   // Cor de fundo ao clicar
            sinLabel.textColor = .black                       // Cor do texto
            layer.borderColor = UIColor.black.cgColor         // Cor do Stroke
            layer.borderWidth = 2                             // Largura do Stroke
            layer.cornerRadius = 10                           // Raio dos cantos
            clipsToBounds = true
        } else {
            // Retorna à aparência original
            backgroundCardView.backgroundColor = .white       // Cor de fundo original
            sinLabel.textColor = .black                       // Cor do texto original
            sinLabel.font = UIFont.systemFont(ofSize: 16)     // Fonte normal
            layer.borderWidth = 0                             // Remove a borda
        }
    }
}
