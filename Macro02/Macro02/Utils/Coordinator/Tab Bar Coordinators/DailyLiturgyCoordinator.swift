//
//  DailyLiturgyCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class DailyLiturgyCoordinator: Coordinator {
    
    // Primeira View desta Tab
    var rootViewController: DailyLiturgyViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
    
    init() {
        self.rootViewController = DailyLiturgyViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {
        self.rootViewController.coordinator = self
    }
}
