//
//  FontStyle.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 20/09/24.
//

import UIKit


/// Enum que define os estilos de fonte do projeto
enum FontStyle {
    case titulo1
    case titulo2
    case textoNormal
    case textoSecundario
    case textoDetalhe
}

extension UIFont {
    /// Função que retorna a fonte personalizada e já adiciona Dynamic Types a ela
    static func setCustomFont(_ style: FontStyle) -> UIFont {
        let fontMetrics: UIFontMetrics
        let customFont: UIFont
        
        switch style {
            
        //MARK: - FONTES
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
