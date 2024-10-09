//
//  DailyLiturgyCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class DailyLiturgyCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel: DailyLiturgyViewModel
    
    lazy var dailyLiturgyViewController: DailyLiturgyViewController = {
        let vc = DailyLiturgyViewController(viewModel: viewModel)
        return vc
    }()
    
    init(viewModel: DailyLiturgyViewModel) {
        self.viewModel = viewModel
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([dailyLiturgyViewController], animated: false)
    }
}
