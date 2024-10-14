//
//  OnboardingCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 10/10/24.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    
    var rootViewController = OnboardingViewController()
    var onboardingDidFinish: (() -> Void)?
    
    func start() {
        // Configura o ViewController do onboarding
        rootViewController.coordinator = self
    }
}

extension OnboardingCoordinator {
    
    public func finishOnboarding() {
        // Marca que o onboarding foi concluído
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        onboardingDidFinish?()  // Chama a função para notificar o ApplicationCoordinator
    }
    
}
