//
//  ConfessionCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit
import Combine

class ConfessionCoordinator: Coordinator {
    
    // AuthManager
    private var authManager = AuthManager()
    private var cancellables = Set<AnyCancellable>()
    
    // Primeira View desta Tab
    var rootViewController: ConfessionAuthViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
    
    var viewModel: SinViewModel
   
    init(viewModel: SinViewModel) {
        self.viewModel = viewModel
        
        self.rootViewController = ConfessionAuthViewController(authManager: authManager, viewModel: self.viewModel)
        self.navigationController = UINavigationController(rootViewController: rootViewController)
        
    }
    
    func start() {
        self.rootViewController.coordinator = self
        
        // Monitorando o status da autorização do FaceID
        authManager.$isSuccessfullyAuthorized
            .receive(on: RunLoop.main)
            .sink { [weak self] isSuccessfull in
                self?.handleNavigation(isSuccessfull)
            }
            .store(in: &cancellables)
    }
    
    private func handleNavigation(_ bool: Bool) {
        if bool {
            
            let myConfessionVC = MyConfessionViewController(authManager: authManager, viewModel: viewModel)
            
            self.navigationController.pushViewController(myConfessionVC, animated: true)
        }
    }
}
