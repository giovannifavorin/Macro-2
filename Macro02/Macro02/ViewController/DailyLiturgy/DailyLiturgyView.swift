//
//  DailyLiturgyView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 16/10/2024.
//

import Foundation
import SwiftUI

struct DailyLiturgyView: View {
    @ObservedObject var viewModel: DailyLiturgyViewModel
    @State private var isTextOptionsVisible = false // Controla a visibilidade do modal

    var body: some View {
        VStack {
            HStack{
                Text("Liturgia Diária")
                    .font(.largeTitle)
                    .padding(.leading, 16)
                
                Spacer()
                Button(action: {
                    isTextOptionsVisible.toggle() // Abre o modal de opções de texto
                }) {
                    Text("Aa")
                        .font(.title2)
                        .padding(.trailing, 16)
                }
//                .sheet(isPresented: $isTextOptionsVisible) {
//                    TextOptionsView(viewModel: viewModel) // Modal com as opções de texto
//                }
            }
            
            // Sempre exibe o LiturgyCardViewWrapper com fallback se os dados forem nil
            LiturgyCardViewWrapper(
                liturgia: viewModel.currentLiturgia ?? Liturgia(
                    data: "N/A",
                    liturgia: nil,
                    cor: nil,
                    dia: "Dia não encontrado",
                    oferendas: nil,
                    comunhao: nil,
                    primeiraLeitura: nil,
                    segundaLeitura: nil,
                    salmo: nil,
                    evangelho: nil,
                    antifonas: nil
                )
            )
            .frame(height: UIScreen.main.bounds.height * 0.1)
            .padding()
            
            
            Picker("Segmento", selection: $viewModel.selectedSegmentIndex) {
                Text("1 Leitura").tag(0)
                Text("Salmos").tag(1)
                Text("Evangelho").tag(2)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding(.horizontal, 16)
            .onChange(of: viewModel.selectedSegmentIndex) { _ in
                viewModel.updateLiturgyText()
            }
            
            ScrollView {
                Text(viewModel.liturgyText)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
            }
            Spacer()
            
        }
        .onAppear {
            viewModel.fetchLiturgyData()
        }
        
    }
}

#Preview {
    DailyLiturgyView(viewModel: DailyLiturgyViewModel())
}
