//
//  ScaledFont.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit

extension UILabel {
    
    /// Função que permite o uso de Dynamic Type com valores fixos de fonte.
    /// Serve para deixar qualquer UIFont dinâmica
    /// - Parameters:
    ///   - name: O nome da fonte a ser usada. O padrão é o nome da família da fonte do sistema.
    ///   - size: O tamanho da fonte.
    ///   - weight: O peso da fonte. O padrão é `.regular`.
    func setDynamicFont(name: String? = nil, size: CGFloat, weight: UIFont.Weight? = .regular) {
        
        var font: UIFont
        
        if let name = name {
            font = UIFont(name: name, size: size) ?? UIFont.systemFont(ofSize: size, weight: weight ?? .regular)

        } else {
            font = UIFont.systemFont(ofSize: size, weight: weight ?? .regular)
        }
    
        self.font = UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
        self.adjustsFontForContentSizeCategory = true
    }
}
