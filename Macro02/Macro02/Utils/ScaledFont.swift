//
//  ScaledFont.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit
extension UIFont {
    // Função que retorna a fonte personalizada com suporte a Dynamic Type
    static func customFont(for style: FontStyle) -> UIFont {
        let fontMetrics: UIFontMetrics
        let customFont: UIFont
        
        switch style {
        case .titulo1:
            customFont = UIFont(name: "CustomFont-Bold", size: 24.0) ?? UIFont.systemFont(ofSize: 24.0, weight: .bold)
            fontMetrics = UIFontMetrics(forTextStyle: .largeTitle)
            
        case .titulo2:
            customFont = UIFont(name: "CustomFont-SemiBold", size: 20.0) ?? UIFont.systemFont(ofSize: 20.0, weight: .semibold)
            fontMetrics = UIFontMetrics(forTextStyle: .title2)
            
        case .textoNormal:
            customFont = UIFont(name: "CustomFont-Regular", size: 16.0) ?? UIFont.systemFont(ofSize: 16.0, weight: .regular)
            fontMetrics = UIFontMetrics(forTextStyle: .body)
            
        case .textoSecundario:
            customFont = UIFont(name: "CustomFont-Regular", size: 14.0) ?? UIFont.systemFont(ofSize: 14.0, weight: .regular)
            fontMetrics = UIFontMetrics(forTextStyle: .subheadline)
            
        case .textoDetalhe:
            customFont = UIFont(name: "CustomFont-Light", size: 12.0) ?? UIFont.systemFont(ofSize: 12.0, weight: .light)
            fontMetrics = UIFontMetrics(forTextStyle: .footnote)
        }
        
        // Aplica o escalonamento dinâmico usando UIFontMetrics
        return fontMetrics.scaledFont(for: customFont)
    }
}

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
