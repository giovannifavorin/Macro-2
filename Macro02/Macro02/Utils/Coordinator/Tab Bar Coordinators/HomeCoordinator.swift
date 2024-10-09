//
//  HomeCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit
import Combine

class HomeCoordinator: Coordinator {
    
    // MARK: - VARIÁVEIS
    var navigationController: UINavigationController
    var rootViewController: HomeViewController
    
    // Esta ViewModel é pedida como parâmetro porque será passada para diferentes VC's em fluxos diferentes
    // Portanto, será instanciada no Coordinator principal para manter uma única instância
    var sinViewModel: SinViewModel
    
    // MARK: - INIT
    init(sinViewModel: SinViewModel) {
        self.rootViewController = HomeViewController()
        self.navigationController = UINavigationController(rootViewController: rootViewController)
        
        self.sinViewModel = sinViewModel
    }
    
    // MARK: - START
    func start() {
        // Define o Coordinator da HomeViewController
        self.rootViewController.coordinator = self
    }
    
    // MARK: - FUNÇÕES AUXILIARES
    private func startConsciousnessExamCoordinator() {
        
        let consciousnessCoordinator = CounsciousnessExamCoordinator(viewModel: self.sinViewModel, navigationController: self.navigationController)
        
        consciousnessCoordinator.start()
    }
    
    private func startLiturgicalCalendarCoordinator() {
        // instanciar viewModels apenas dentro do escopo das suas respectivas funções
    }
    
    private func startPenanceCoordinator() {
        
    }
    
    private func startTodaysSaintCoordinator() {
        
    }
    
    private func startPrayersCoordinator() {
        
        let prayersViewModel = PrayersViewModel()
        let prayersCoordinator = PrayersCoordinator(viewModel: prayersViewModel, navigationController: self.navigationController)
        
        prayersCoordinator.start()
    }
}

// Funções públicas -- Boa prática deixar separado na extension
extension HomeCoordinator {
    
    public func handleNavigation(_ navigation: NavigationCases) {
        // Inicia a navegação dependendo do botão selecionado na Home
        switch navigation {
        case .counsciousnessExam:
            startConsciousnessExamCoordinator()
            
        case .liturgicalCalendar:
            startLiturgicalCalendarCoordinator()
            
        case .penance:
            startPenanceCoordinator()
            
        case .todaysSaint:
            startTodaysSaintCoordinator()
            
        case .prayers:
            startPrayersCoordinator()
            
        case .none:
            break
        }
    }
}
