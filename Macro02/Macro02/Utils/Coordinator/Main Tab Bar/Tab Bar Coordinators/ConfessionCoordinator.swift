//
//  ConfessionCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit
import Combine

class ConfessionCoordinator: Coordinator {
    
    // RootViewController
    var rootViewController: UINavigationController
    
    // ViewModel para o FaceID
    var faceidViewModel = ConfessionViewModel()
    
    // ViewModel dos pecados
    var viewModel: SinViewModel
    
    // VC da view do FaceID
    lazy var confessionAuthViewController: ConfessionAuthViewController = {
        let vc = ConfessionAuthViewController(viewModel: self.faceidViewModel)
        return vc
    }()
    
    
    // Combine
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: SinViewModel) {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
        
        self.viewModel = viewModel
    }
    
    func start() {
        rootViewController.setViewControllers([confessionAuthViewController], animated: false)
        
        // Escutando alteração quando a permissão do FaceID
        faceidViewModel.$isSuccessfullyAuthorized
            .receive(on: RunLoop.main)
            .sink { [weak self] success in
                self?.handleNavigation(success)
            }
            .store(in: &cancellables)
    }
    
    private func handleNavigation(_ success: Bool) {
        if success {
            rootViewController.pushViewController(MyConfessionViewController(viewModel: self.viewModel), animated: true)
        }
    }
}
