//
//  OnboardingFirstView.swift
//  Macro02
//
//  Created by Victor Dantas on 11/10/24.
//

import SwiftUI

struct OnboardingFirstView: View {
    
    var nextPageAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            OnboardingContent(title: "Bem-vindo ao Peregrinus!",
                              text: "Um guia completo para fortalecer sua jornada espiritual, com tudo o que você precisa em um só lugar.",
                              buttonTxt: "Começar Agora",
                              image: Image(systemName: "photo"),
                              size: size,
                              nextPageAction: nextPageAction)
        }
    }
}

#Preview {
    OnboardingFirstView()
}



