//
//  ApplicationCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit

// Coordinator principal, o ponto inicial do app
class ApplicationCoordinator: Coordinator {
    
    // Por isso o Coordinator deve ser um protocolo, assim os "child" podem conformar com esse tipo,
    // permitindo que múltiplos Coordinators possam ser armazenados nessa variável
    var childCoordinators = [Coordinator]()
    
    // "window" passada pelo SceneDelegate
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        
        // Coordinator principal, da navegação da Tab Bar
        let mainCoordinator = MainTabBarCoordinator()
        mainCoordinator.start()
        
        self.childCoordinators.append(mainCoordinator)
        
        self.window.rootViewController = mainCoordinator.rootViewController
        
        self.window.makeKeyAndVisible()
    }
}
