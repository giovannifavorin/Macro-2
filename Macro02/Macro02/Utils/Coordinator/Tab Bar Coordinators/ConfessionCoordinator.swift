//
//  ConfessionCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class ConfessionCoordinator: Coordinator {
    
    // Primeira View desta Tab
    var rootViewController: ConfessionAuthViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
   
    init() {
        self.rootViewController = ConfessionAuthViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {
        self.rootViewController.coordinator = self
    }
}
