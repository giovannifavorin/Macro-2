//
//  HomeCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class HomeCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel = HomeViewModel()
    
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }()
    
    init() {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
    }
}
