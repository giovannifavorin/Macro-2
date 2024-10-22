//
//  AboutCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class AboutCoordinator: Coordinator {
    
    // Primeira View desta Tab
    var rootViewController: AboutViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
   
    init() {
        self.rootViewController = AboutViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {
        self.rootViewController.coordinator = self
    }
}
