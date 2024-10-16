//
//  ConsciousnessExamCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit

// Coordinator responsável pelo fluxo do Exame de Consciência
class ConsciousnessExamCoordinator: Coordinator {
    
    var viewModel: SinViewModel
    var rootViewController: ConsciousnessExamViewController
    var navigationController: UINavigationController
    
    init(viewModel: SinViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        
        self.rootViewController = ConsciousnessExamViewController(viewModel: viewModel)
        self.rootViewController.coordinator = self
    }
        
    func start() {
        // DEBUG
        print("Navegando para Exame de Consciência")
        
        // Define a viewModel da View atual, bem como seu coordinator (self)
        self.rootViewController.coordinator = self
        
        // Navega para a primeira View do fluxo
        self.navigationController.pushViewController(self.rootViewController, animated: true)
        
    }
}

extension ConsciousnessExamCoordinator {
    
    public func handleNavigation() {
        
    }
    
}
