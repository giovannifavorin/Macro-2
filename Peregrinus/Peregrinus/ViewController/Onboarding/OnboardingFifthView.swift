//
//  OnboardingFifthView.swift
//  Macro02
//
//  Created by Victor Dantas on 11/10/24.
//

import SwiftUI

struct OnboardingFifthView: View {
    
    var finishAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            OnboardingContent(title: "Mantenha-se Conectado",
                              text: "Receba lembretes diários de leituras, orações e reflexões para manter sua fé ativa.",
                              buttonTxt: "Finalizar Onboarding",
                              image: Image(systemName: "photo"),
                              size: size,
                              nextPageAction: finishAction)
        }
    }
}

#Preview {
    OnboardingFifthView()
}

