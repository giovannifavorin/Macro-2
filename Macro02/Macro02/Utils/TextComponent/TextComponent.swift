//
//  TextComponent.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 17/09/24.
//

import UIKit

class TextComponent: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setScaledFont(size: 18, weight: .regular)
        self.textColor = .label
        self.textAlignment = .center
        self.numberOfLines = 0  // Permite múltiplas linhas
        
    }
    
    private func addAccessibility() {
        self.isUserInteractionEnabled = true
        self.accessibilityLabel = accessibilityLabel ?? self.text // Define o texto como o rótulo de acessibilidade
        self.accessibilityTraits = .staticText
    }
    
    func definirTexto(string:  String.LocalizationValue) {
        self.text = String(localized:string, table: nil)
    }
}

