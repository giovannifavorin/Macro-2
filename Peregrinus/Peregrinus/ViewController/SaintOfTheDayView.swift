//
//  SaintOfTheDayView.swift
//  Peregrinus
//
//  Created by Giovanni Favorin de Melo on 23/10/24.
//

import SwiftUI

struct SaintOfTheDayView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 16) {
                // Image placeholder
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 200)
                    .overlay(
                        Text("Imagem")
                            .foregroundColor(.gray)
                    )

                // Text content
                VStack(alignment: .leading, spacing: 8) {
                    Text("São Jerônimo")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Presbítero e doutor da Igreja")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("30 de setembro de 2024")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Divider()

                    // Description Section
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Origem")
                            .font(.headline)

                        Text("Sofrônio Eusébio Jerônimo é o nome completo de São Jerônimo. Nasceu em Estridão, atual Croácia. Não se sabe a data exata do seu nascimento.")
                            .font(.body)
                    }
                }
                .padding()

                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Add action for back button
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Add action for "Aa" button
                    }) {
                        Text("Aa")
                            .foregroundColor(.blue)
                    }
                }
            }
            .background(Color(UIColor.systemBackground))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct SaintOfTheDayView_Previews: PreviewProvider {
    static var previews: some View {
        SaintOfTheDayView()
            .preferredColorScheme(.light) // Test in light mode
        SaintOfTheDayView()
            .preferredColorScheme(.dark)  // Test in dark mode
    }
}

