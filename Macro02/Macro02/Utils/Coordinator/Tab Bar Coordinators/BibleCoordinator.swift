//
//  BibleCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleCoordinator: Coordinator {
    
    // Primeira View desta Tab
    var rootViewController: BibleViewController
    
    // Navigation Controller deste fluxo
    var navigationController: UINavigationController
   
    init() {
        self.rootViewController = BibleViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
    }
    
    func start() {
        self.rootViewController.coordinator = self
    }
    
    func showChapters(do book: Book) {
        let chaptersVC = ChaptersViewController()
        chaptersVC.viewModel = ChaptersViewModel(book: book)
        navigationController.pushViewController(chaptersVC, animated: true)
    }
}
