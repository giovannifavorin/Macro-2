//
//  ScaledFont.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit

extension UILabel {
    
    /// Modificador que permite dynamic type usando valores fixos de fonte
    /// - Parameters:
    ///   - name: O nome da fonte a ser usada. O padrão é o nome da família da fonte do sistema.
    ///   - size: O tamanho da fonte.
    ///   - weight: O peso da fonte. O padrão é `.regular`.
    func setScaledFont(name: String = UIFont.systemFont(ofSize: 0).familyName, size: CGFloat, weight: UIFont.Weight = .regular) {
        let fontMetrics = UIFontMetrics(forTextStyle: .body)
        // Corrigido: usa a família da fonte e cria uma com o peso específico
        let customFont = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size)
        let weightedFont = customFont.withWeight(weight)
        self.font = fontMetrics.scaledFont(for: weightedFont)
        self.adjustsFontForContentSizeCategory = true // Habilita o ajuste dinâmico
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
