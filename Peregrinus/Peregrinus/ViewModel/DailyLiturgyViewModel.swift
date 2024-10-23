//
//  DailyLiturgyViewModel.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import Foundation
import Combine

class DailyLiturgyViewModel: ObservableObject {
    
    @Published var currentLiturgia: Liturgia?
    @Published var selectedSegmentIndex: Int = 0 {
        didSet {
            updateLiturgyText()  // Atualiza o texto ao mudar o segmento
        }
    }
    @Published var liturgyText: String = "Carregando..."
    
    private let apiManager = APIManager()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        fetchLiturgyData()
    }
    
    // Função para buscar dados da liturgia
    func fetchLiturgyData() {
        let urlString = "https://liturgiadiaria.site" // URL da API
        
        apiManager.fetchData(from: urlString, responseType: Liturgia.self) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let liturgia):
                    self?.currentLiturgia = liturgia
                    self?.updateLiturgyText()  // Atualiza texto após o carregamento
                case .failure(let error):
                    print("Erro ao buscar a liturgia: \(error.localizedDescription)")
                    self?.liturgyText = "Erro ao carregar a liturgia."
                }
            }
        }
    }
    
    // Função para atualizar o texto da liturgia de acordo com o segmento selecionado
    func updateLiturgyText() {
        guard let liturgia = currentLiturgia else {
            liturgyText = "Dados da liturgia não disponíveis."
            return
        }
        
        switch selectedSegmentIndex {
        case 0:
            liturgyText = liturgia.primeiraLeitura?.texto ?? "Texto da primeira leitura não disponível."
        case 1:
            liturgyText = liturgia.salmo?.texto ?? "Texto do salmo não disponível."
        case 2:
            liturgyText = liturgia.evangelho?.texto ?? "Texto do evangelho não disponível."
        default:
            liturgyText = "Segmento inválido."
        }
    }
}
