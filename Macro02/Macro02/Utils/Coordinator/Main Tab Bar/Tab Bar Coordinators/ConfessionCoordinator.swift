//
//  ConfessionCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class ConfessionCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel = ConfessionViewModel()
    
    lazy var confessionViewController: ConfessionViewController = {
        let vc = ConfessionViewController(viewModel: viewModel)
        return vc
    }()
    
    init() {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([confessionViewController], animated: false)
    }
}
