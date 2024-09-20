//
//  PrayersCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import Combine

class PrayersCoordinator: Coordinator {
    
    var viewModel = PrayersViewModel()
    
    lazy var rootViewController: PrayersCategoryViewController = {
        let vc = PrayersCategoryViewController(viewModel: viewModel)
//        vc.hidesBottomBarWhenPushed = false
        return vc
    }()
    
    var cancellables = Set<AnyCancellable>()
    
    func start() {
        
        viewModel.$selectedCategory
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedCategory in
                if let selectedCategory = selectedCategory {
                    self?.handleNavigationCategory(to: selectedCategory)
                }
            }
            .store(in: &cancellables)
        
        viewModel.$selectedPrayer
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedPrayer in
                if let selectedPrayer = selectedPrayer {
                    self?.handleNavigationPrayer(to: selectedPrayer)
                }
            }
            .store(in: &cancellables)
        
    }
    
    private func handleNavigationCategory(to: PrayerCategory) {
        self.rootViewController.navigationController?.pushViewController(PrayersDetailViewController(viewModel: viewModel), animated: true)
    }
    
    private func handleNavigationPrayer(to: Prayer) {
        self.rootViewController.navigationController?.pushViewController(FullPrayerViewController(viewModel: viewModel), animated: true)
    }
}
