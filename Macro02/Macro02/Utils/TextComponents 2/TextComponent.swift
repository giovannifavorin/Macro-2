//
//  TextComponent.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 17/09/24.
//

import UIKit

class TextComponent: UILabel {
    
    ///Init que gera texto padrão com accessibilidade
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addAccessibility()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Faz a configuração básica de todo texto
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = UIFont.customFont(.textoNormal)
        self.textColor = .label
        self.textAlignment = .center
        self.numberOfLines = 0  // Permite múltiplas linhas
        
    }
    
    /// Torna o texto acessível
    private func addAccessibility() {
        self.isUserInteractionEnabled = true
        self.accessibilityLabel = accessibilityLabel ?? self.text // Define o texto como o texto de acessibilidade
        self.accessibilityTraits = .staticText
        self.adjustsFontForContentSizeCategory = true

    }
    
    /// Define texto com Localizable
    func setText(string: String.LocalizationValue) {
        self.text = String(localized: string, table: nil)
    }
}

