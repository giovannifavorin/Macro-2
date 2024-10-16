//
//  OnboardingThirdView.swift
//  Macro02
//
//  Created by Victor Dantas on 11/10/24.
//

import SwiftUI

struct OnboardingThirdView: View {
    var nextPageAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            OnboardingContent(title: "Conecte-se com a Palavra de Deus",
                              text: "Acesse a liturgia diária e a Bíblia completa, com reflexões e marcações para acompanhar sua leitura.",
                              buttonTxt: "Próximo",
                              image: Image(systemName: "photo"),
                              size: size,
                              nextPageAction: nextPageAction)
        }
    }
}

#Preview {
    OnboardingThirdView()
}
