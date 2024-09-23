//
//  ButtonComponent.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit

class ButtonComponent: UIButton {
    private var textComponent: TextComponent
    
    private var action: (() -> Void)?
    
    override init(frame: CGRect) {
        self.textComponent = TextComponent()
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        self.textComponent = TextComponent()
        super.init(coder: coder)
        setupView()
    }
    
    ///Configuração básica do botão
    private func setupView() {
        self.addSubview(textComponent)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Constraints do TextComponent
        NSLayoutConstraint.activate([
            textComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textComponent.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textComponent.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9),
            textComponent.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 0.9)
        ])
        
        self.accessibilityHint = "Button"
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.white, for: .normal)
        
        self.accessibilityTraits.insert(.button)
        self.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    ///Configura a Label de button e adiciona uma função a ele
    func configure(label: TextComponent, action: (() -> Void)? = nil) {
        self.textComponent = label
        self.action = action
        self.accessibilityLabel = self.textComponent.text
    }
        
    @objc private func buttonTapped() {
        action?() // Chama a ação quando o botão é pressionado
    }
}
