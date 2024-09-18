//
//  BibleCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel = BibleViewModel()
    
    lazy var bibleViewController: BibleViewController = {
        let vc = BibleViewController(viewModel: viewModel)
        return vc
    }()
    
    init() {
        self.rootViewController = UINavigationController()
        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([bibleViewController], animated: false)
    }
}
