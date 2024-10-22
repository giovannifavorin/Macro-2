//
//  ButtonComponent.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit

class ButtonComponent: UIButton {
    private let textComponent: TextComponent
    
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
    
    private func setupView() {
        // Configura o botão
        self.addSubview(textComponent)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        // Constrangimentos do TextComponent
        NSLayoutConstraint.activate([
            textComponent.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textComponent.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            textComponent.widthAnchor.constraint(lessThanOrEqualTo: self.widthAnchor, multiplier: 0.9),
            textComponent.heightAnchor.constraint(lessThanOrEqualTo: self.heightAnchor, multiplier: 0.9)
        ])
        
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8.0
        self.setTitleColor(.white, for: .normal)
        
        self.accessibilityLabel = "Button"
        self.accessibilityTraits.insert(.button)
        self.adjustsImageSizeForAccessibilityContentSizeCategory = true
        
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    ///Configura o texto do button e adicionar uma função a ele
    func configure(label: TextComponent, action: (() -> Void)? = nil) {
        self.textComponent.text = label.text // Atribui o texto do TextComponent recebido
        self.action = action
    }
        
    @objc private func buttonTapped() {
        action?() // Chama a ação quando o botão é pressionado
    }
}
