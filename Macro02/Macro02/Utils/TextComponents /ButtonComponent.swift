//
//  ButtonComponent.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit

class ButtonComponent: UIButton {
    
    private var action: (() -> Void)?
    
    /// Init que torna texto do btn Localizable e action
    init(_ text: String.LocalizationValue, action: @escaping () -> Void = {}) {
        super.init(frame: .zero)
        self.action = action
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        configureButton()
        setText(text, for: .normal)
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
        setDefaultAppearance()
        addAccessibility()
    }
    
    /// Função para aplicar a aparência padrão ao button
    private func setDefaultAppearance() {
        translatesAutoresizingMaskIntoConstraints = false
        
        // Utilizando UIButtonConfiguration para customizar o botão
        var config = UIButton.Configuration.filled() // Configuração preenchida (com fundo)
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        
        // Definir padding entre o texto e as bordas do botão
        config.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
        self.configuration = config
    }

    /// Func que configura acessiblidade do btn
    private func addAccessibility() {
        //MARK: Voice Over
        self.isUserInteractionEnabled = true
        self.titleLabel?.accessibilityLabel = self.titleLabel?.text // Define o texto como o texto de acessibilidade
        self.accessibilityLabel = self.titleLabel?.text // Define a label do proptio titulo como o texto de acessibilidade
        self.accessibilityHint = "Button" // Define o Hint como 'Button'
        self.accessibilityTraits = .button // informa ao usuário que é um button
        
        //MARK: Dynamic Types
        self.titleLabel?.adjustsFontForContentSizeCategory = true // Adiciona Dynamic Types
    }
    
    //MARK: Localizable
    /// Função para atualizar/definir com textLocalizable
    func setText(_ text: String.LocalizationValue, for controlStage: UIControl.State) {
        let localizedString = String(localized: text) // Conversão de LocalizationValue para String
        self.titleLabel?.text = localizedString
        self.setTitle(localizedString, for: controlStage)
    }

    /// Ação executada quando o botão é pressionado
    @objc private func buttonTapped() {
        action?()
    }
}
