//
//  DailyLiturgyView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 16/10/2024.
//

import Foundation
import SwiftUI

struct DailyLiturgyView: View {
    var title: String
    @Binding var selectedSegment: Int
    @Binding var liturgyText: String
    var onTextSizeTap: () -> Void
    
    var body: some View {
        VStack {
            HStack{
                Text(title)
                    .font(.title)
                    .foregroundStyle(.black)
                    .fontWeight(.bold)
                    .padding(.leading, 16)
                
                Spacer()
                
                Button ("Aa") {
                    
                }
                .padding(.trailing, 16)
                .foregroundStyle(.black)
                
                
            }
            .padding(.top, 16)
            
//            LiturgyCardView() // Placeholder para o cartão de liturgia
            
            Picker("", selection: $selectedSegment) {
                Text("1 Leitura").tag(0)
                Text("Salmos").tag(1)
                Text("Evangelho").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .onChange(of: selectedSegment) { _ in
                // Lógica do Picker tratada na ViewController
            }
            
            ScrollView {
                Text(liturgyText)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        
    }
}

#Preview {
    DailyLiturgyView(
        title: "Dayli Liturgy",
        selectedSegment: .constant(0),
        liturgyText: .constant("Litugy text"),
        onTextSizeTap: {}
    )
}

