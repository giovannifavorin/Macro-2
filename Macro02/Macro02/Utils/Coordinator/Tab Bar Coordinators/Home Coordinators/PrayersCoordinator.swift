//
//  PrayersCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit

class PrayersCoordinator: Coordinator {
    
    var viewModel: PrayersViewModel
    var rootViewController: PrayersCategoryViewController
    var navigationController: UINavigationController
    
    init(viewModel: PrayersViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
        
        self.rootViewController = PrayersCategoryViewController()
    }
    
    func start() {
        // DEBUG
        print("Navegando para Orações")
        
        // Define a View atual da viewModel como a primeira do fluxo (que será navegada)
        viewModel.view = self.rootViewController
        
        // Define a viewModel da View atual, bem como seu coordinator (self)
        self.rootViewController.viewModel = viewModel
        self.rootViewController.coordinator = self
        
        // Navega para a primeira View do fluxo
        self.navigationController.pushViewController(self.rootViewController, animated: true)
    }
     
    
}

extension PrayersCoordinator {
    
    // Navegação da Categoria para a Detalhes
    public func navigateToDetail(category: PrayerCategory) {
        
        let detailVC = PrayersDetailViewController(viewModel: viewModel, category: category)
        detailVC.coordinator = self
        
        self.navigationController.pushViewController(detailVC, animated: true)
    }
    
    // Navegação dos Detalhes para a Oração completa
    public func navigateToFull(prayer: Prayer) {
        
        let fullPrayerVC = FullPrayerViewController(viewModel: viewModel, prayer: prayer)
        fullPrayerVC.coordinator = self
        
        self.navigationController.pushViewController(fullPrayerVC, animated: true)
    }
    
    public func navigateToModal(vc: FullPrayerViewController) {
        
        let modalVC = PrayerOptionsModalViewController(viewModel: viewModel)
        modalVC.modalPresentationStyle = .pageSheet
        vc.present(modalVC, animated: true)
    }
    
}

enum PrayersNavCases {
    case detail
    case full
    case modal
}
