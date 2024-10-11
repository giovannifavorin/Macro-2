//
//  ApplicationCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit
import Combine

// Coordinator principal, o ponto inicial do app -- TAB BAR
class ApplicationCoordinator: Coordinator {
    
    // "window" passada pelo SceneDelegate
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window // pede a window como parâmetro para o SceneDelegate
    }
    
    func start() {
        // DEBUG
        print("Application Coordinator --- STARTED")
        
        // UserDefaults para monitorar se o usuário já viu ou não o Onboarding
        let hasSeenOnboarding = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
        
        
        if hasSeenOnboarding {
            self.startMainTabFlow()
        } else {
            self.startOnboardingFlow()
        }
        
        
        // Basicamente faz as coisas aparecerem, tem que ter
        self.window.makeKeyAndVisible()
        
        
    }
    
    private func startMainTabFlow() {
        // Se já viu o Onboarding
        let mainTabCoordinator = MainTabBarCoordinator() // Inicializa o Coordinator da Tab Bar princiapl do app
        mainTabCoordinator.start()                       // Chama a função start do Coordinator
        
        // Define a rootViewController da window como a Tab Bar
        self.window.rootViewController = mainTabCoordinator.tabBarController
    }
    
    private func startOnboardingFlow() {
        // Se ainda não viu o Onboarding
        let onboardingCoordinator = OnboardingCoordinator()
        onboardingCoordinator.start()
        
        // Define a rootViewController da window como a OnboardingViewController
        self.window.rootViewController = onboardingCoordinator.rootViewController
        
        // Callback quando o onboarding for finalizado
        onboardingCoordinator.onboardingDidFinish = { [weak self] in
            self?.startMainTabFlow()  // Inicia a Tab Bar após o onboarding
        }
    }
    
}
