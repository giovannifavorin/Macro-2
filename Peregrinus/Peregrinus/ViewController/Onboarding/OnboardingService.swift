//
//  OnboardingService.swift
//  Macro02
//
//  Created by Victor Dantas on 14/10/24.
//

import Foundation

// Protocolo que define os métodos necessários para gerenciar o estado do onboarding
protocol OnboardingServiceProtocol {
    func hasSeenOnboarding() -> Bool // Verifica se o usuário já completou o onboarding
    func markOnboardingAsSeen() // Marca o onboarding como concluído
}

// Serviço que implementa o OnboardingServiceProtocol e usa o UserDefaults para armazenar o estado
class OnboardingService: OnboardingServiceProtocol {
    
    private let userDefaults: UserDefaults
    
    // Inicializa o serviço com uma instância de UserDefaults, usando .standard como padrão
    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }
    
    // Verifica se o usuário já completou o onboarding lendo o valor de UserDefaults
    func hasSeenOnboarding() -> Bool {
        return userDefaults.bool(forKey: "hasSeenOnboarding")
    }
    
    // Marca o onboarding como concluído gravando no UserDefaults
    func markOnboardingAsSeen() {
        DispatchQueue.global(qos: .background).async {
            // Executa de forma assíncrona para não bloquear a UI thread
            self.userDefaults.set(true, forKey: "hasSeenOnboarding")
        }
    }
}
