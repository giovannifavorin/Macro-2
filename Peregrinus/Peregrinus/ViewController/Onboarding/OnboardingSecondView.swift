//
//  OnboardingSecondView.swift
//  Macro02
//
//  Created by Victor Dantas on 11/10/24.
//

import SwiftUI

struct OnboardingSecondView: View {
    
    var nextPageAction: (() -> Void)?
    
    var body: some View {
        GeometryReader { geometry in
            
            let size = geometry.size
            
            OnboardingContent(title: "Prepare-se para a Confissão",
                              text: "Exame de consciência e orações de preparação e contrição. Organize-se para viver esse sacramento com paz e clareza.",
                              buttonTxt: "Próximo",
                              image: Image(systemName: "photo"),
                              size: size,
                              nextPageAction: nextPageAction)
        }
    }
}

#Preview {
    OnboardingSecondView()
}
