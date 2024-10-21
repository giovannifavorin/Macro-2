//
//  ConsciousnessExamCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit
import SwiftUI

// Coordinator responsável pelo fluxo do Exame de Consciência
class ConsciousnessExamCoordinator: Coordinator {
    
    var viewModel: SinViewModel
    var navigationController: UINavigationController
    
    // Instância como lazy para conseguir passar a si mesmo (self) como parâmetro, só depois que "self" está inicializado
    var rootViewController: SacramentOfConfessionViewController?
    
    init(viewModel: SinViewModel, navigationController: UINavigationController) {
        self.viewModel = viewModel
        self.navigationController = navigationController
    }
        
    func start() {
        // DEBUG
        print("Navegando para Exame de Consciência")
        
        // Define a View atual da viewModel como a primeira do fluxo (que será navegada)
        viewModel.view = self.rootViewController
        
        // Navega para a primeira View do fluxo
        self.rootViewController = SacramentOfConfessionViewController()
        
        if let rootViewController = self.rootViewController {
            rootViewController.coordinator = self
            rootViewController.navigationItem.hidesBackButton = true
            rootViewController.hidesBottomBarWhenPushed = true
            self.navigationController.pushViewController(rootViewController, animated: true)
        }
        
    }
    
    // MARK: - Funções de navegação
    private func navigateToPreparatoryPrayer() {
        let view = PreparatoryPrayerViewController()
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToConsciousnessExamFirst() {
        let view = ConsciousnessExamFirstViewController()
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToConsciousnessExamSecond() {
        let view = ConsciousnessExamSecondViewController(viewModel: self.viewModel)
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToConsciousnessExamThird() {
        let view = ConsciousnessExamThirdViewController(viewModel: self.viewModel)
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToConsciousnessExamFourth() {
        let view = ConsciousnessExamFourthViewController(viewModel: self.viewModel)
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToActOfContritionFirst() {
        let view = ActOfContritionFirstViewController()
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToActOfContritionSecond() {
        let view = ActOfContritionSecondViewController()
        view.coordinator = self
        view.navigationItem.hidesBackButton = true
        self.navigationController.pushViewController(view, animated: false)
    }
    
    private func navigateToReadyToConfess(vc: UIViewController) {
        let modal = ReadyToConfessModalViewController(viewModel: self.viewModel)
        modal.coordinator = self
        modal.modalPresentationStyle = .automatic
        
        vc.present(modal, animated: true)
    }
}

extension ConsciousnessExamCoordinator {
    
    public func handleNavigation(_ navigation: ConsciousnessExamNavigationCases, vc: ActOfContritionSecondViewController? = nil) {
        switch navigation {
            
        case .preparatoryPrayer:
            navigateToPreparatoryPrayer()
            
        case .consciousnessExamFirst:
            navigateToConsciousnessExamFirst()
            
        case .consciousnessExamSecond:
            navigateToConsciousnessExamSecond()
            
        case .consciousnessExamThird:
            navigateToConsciousnessExamThird()
            
        case .consciousnessExamFourth:
            navigateToConsciousnessExamFourth()
            
        case .actOfContritionFirst:
            navigateToActOfContritionFirst()
            
        case .actOfContritionSecond:
            navigateToActOfContritionSecond()
            
        case .readyToConfess:
            guard let vc else { return }
            navigateToReadyToConfess(vc: vc)
            
        case .back:
            self.navigationController.popViewController(animated: false)
        case .popToRoot:
            self.navigationController.popToRootViewController(animated: true)
        }
    }
    
}

enum ConsciousnessExamNavigationCases {

    case preparatoryPrayer
    case consciousnessExamFirst
    case consciousnessExamSecond
    case consciousnessExamThird
    case consciousnessExamFourth
    case actOfContritionFirst
    case actOfContritionSecond
    case readyToConfess
    
    case back
    
    case popToRoot
}
