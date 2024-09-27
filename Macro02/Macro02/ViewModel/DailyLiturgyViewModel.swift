//
//  DailyLiturgyViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import SwiftUI

class DailyLiturgyViewModel: ObservableObject {
    @Published var liturgia: Liturgia?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private var apiManager = LiturgiaDiariaAPI()
    
    func fetchLiturgiaDiaria() {
        isLoading = true
        apiManager.fetchLiturgia { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let liturgia):
                    self?.liturgia = liturgia
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
