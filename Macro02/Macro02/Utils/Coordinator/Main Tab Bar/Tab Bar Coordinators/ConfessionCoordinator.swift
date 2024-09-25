//
//  ConfessionCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit
import Combine

class ConfessionCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel = ConfessionViewModel()
    
    lazy var confessionAuthViewController: ConfessionAuthViewController = {
        let vc = ConfessionAuthViewController(viewModel: viewModel)
        return vc
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([confessionAuthViewController], animated: false)
        
        viewModel.$isSuccessfullyAuthorized
            .receive(on: RunLoop.main)
            .sink { [weak self] success in
                self?.handleNavigation(success)
            }
            .store(in: &cancellables)
    }
    
    private func handleNavigation(_ success: Bool) {
        if success {
            rootViewController.pushViewController(MyConfessionViewController(viewModel: viewModel), animated: true)
        }
    }
}
