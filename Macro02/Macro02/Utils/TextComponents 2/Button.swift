//
//  Button.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 24/09/24.
//

import UIKit

class Buttton: UIButton {
    private var action: (() -> Void)?
    
    // Inicializador que aceita um texto de localização e uma ação de clique
    init(_ text: String.LocalizationValue, action: @escaping () -> Void) {
        super.init(frame: .zero)
        self.action = action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButton()
        setText(text)
    }
    
    // Inicializador padrão
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
    }
    
    /// Função de configuração padrão do botão
    private func configureButton() {
        // Configurar aparência padrão
        setDefaultAppearance()
        addAccessibility()
    }
    
    // Função para aplicar a aparência padrão
    private func setDefaultAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBlue
        setTitleColor(.white, for: .normal)
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        contentEdgeInsets = UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 16)
    }
    
    private func addAccessibility() {
        self.isUserInteractionEnabled = true
        self.titleLabel?.accessibilityLabel = self.titleLabel?.text // Define o texto como o texto de acessibilidade
        self.accessibilityLabel = self.titleLabel?.text
        self.accessibilityHint = "Button"

        self.accessibilityTraits = .staticText
        self.titleLabel?.adjustsFontForContentSizeCategory = true
    }
    
    /// Função para atualizar o título com base na StringCatalog
    func setText(_ text: String.LocalizationValue) {
        let localizedString = String(localized: text) // Conversão de LocalizationValue para String
        self.titleLabel?.text = localizedString
        self.setTitle(localizedString, for: .normal)
    }

    // Ação executada quando o botão é pressionado
    @objc private func buttonTapped() {
        action?()
    }
}
