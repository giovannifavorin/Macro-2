//
//  AboutCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class AboutCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel: AboutViewModel
    
    lazy var aboutViewController: AboutViewController = {
        let vc = AboutViewController(viewModel: viewModel)
        return vc
    }()
    
    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([aboutViewController], animated: false)
    }
}
