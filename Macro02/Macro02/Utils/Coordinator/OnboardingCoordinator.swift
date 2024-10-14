//
//  OnboardingCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 10/10/24.
//

import UIKit

// Coordinator responsável por gerenciar o fluxo do onboarding
class OnboardingCoordinator: Coordinator {
    
    var rootViewController = OnboardingPageViewController() // Controlador de página do onboarding
    private let onboardingService: OnboardingServiceProtocol // Serviço de onboarding para gerenciar o estado
    
    var onboardingDidFinish: (() -> Void)? // Closure que será chamada quando o onboarding for finalizado
    
    // Inicializa o OnboardingCoordinator com o serviço de onboarding
    init(onboardingService: OnboardingServiceProtocol) {
        self.onboardingService = onboardingService
    }
    
    // Método que inicia o Onboarding Coordinator, configurando o controlador de páginas
    func start() {
        rootViewController.coordinator = self // Define a referência ao coordinator no PageViewController
    }
    
    // Método que finaliza o onboarding e marca como concluído
    public func finishOnboarding() {
        onboardingService.markOnboardingAsSeen() // Marca que o onboarding foi concluído
        onboardingDidFinish?() // Chama a closure para notificar o ApplicationCoordinator
    }
}

