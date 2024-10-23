//
//  OnboardingContentView.swift
//  Macro02
//
//  Created by Victor Dantas on 14/10/24.
//

import SwiftUI

struct OnboardingContent: View {
    
    var title: String
    var text: String
    var buttonTxt: String
    var image: Image
    
    var size: CGSize
    
    var nextPageAction: (() -> Void)?
    
    var body: some View {
        ZStack {
            VStack {
                
                image
                    .resizable()
                    .scaledToFit()
                    .padding()
                
                ZStack {
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(style: StrokeStyle(lineWidth: 1))
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Text(title)
                            .frame(width: size.width * 0.8)
                            .padding(.top, size.height * 0.1)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        Text(text)
                            .frame(width: size.width * 0.8)
                            .multilineTextAlignment(.center)
                            .font(.title3)
                        
                        Spacer()
                        
                        Button {
                            nextPageAction?() // Chama a closure para avançar a página
                        } label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: (size.height * 0.08) / 2)
                                    .frame(width: size.width * 0.6, height: size.height * 0.08)
                                    .foregroundStyle(.black)
                                    .padding()
                                
                                Text(buttonTxt)
                                    .font(.title3)
                                    .foregroundStyle(.white)
                                    .bold()
                            }
                            .padding(.bottom, size.height * 0.05)
                        }
                    }
                }
            }
        }
    }
}
