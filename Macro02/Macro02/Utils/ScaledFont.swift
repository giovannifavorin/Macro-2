//
//  ScaledFont.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit


extension UILabel {
    /// Define a fonte escalável usando o estilo customizado com suporte a Dynamic Type
    /// - Parameter style: Estilo da fonte baseado no enum `FontStyle`
    func setFontStyle(_ style: FontStyle) {
        self.font = UIFont.customFont(for: style)
        self.adjustsFontForContentSizeCategory = true // Ativa o Dynamic Type
    }
}

// Extensão para adicionar suporte ao peso da fonte usando UIFontDescriptor
extension UIFont {
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        let systemFontDescriptor = self.fontDescriptor.addingAttributes([
            UIFontDescriptor.AttributeName.traits: [UIFontDescriptor.TraitKey.weight: weight]
        ])
        return UIFont(descriptor: systemFontDescriptor, size: self.pointSize)
    }
}
