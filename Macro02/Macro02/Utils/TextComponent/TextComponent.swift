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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.font = UIFont.systemFont(ofSize: 16)
        self.textColor = .label
        self.textAlignment = .center
        self.numberOfLines = 0  // Permite múltiplas linhas
        self.translatesAutoresizingMaskIntoConstraints = false
        
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
