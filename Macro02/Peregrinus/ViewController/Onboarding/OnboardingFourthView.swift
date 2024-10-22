//
//  OnboardingFourthView.swift
//  Macro02
//
//  Created by Victor Dantas on 11/10/24.
//

import SwiftUI

struct OnboardingFourthView: View {
    var nextPageAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            OnboardingContent(title: "Aprofunde-se nos Ensinamentos da Fé",
                              text: "Explore um vasto conteúdo para fortalecer sua espiritualidade.",
                              buttonTxt: "Próximo",
                              image: Image(systemName: "photo"),
                              size: size,
                              nextPageAction: nextPageAction)
        }
    }
}

#Preview {
    OnboardingFourthView()
}
