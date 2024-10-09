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
    var rootViewController: UINavigationController
    var viewModel: HomeViewModel
    
    var childCoordinators: [Coordinator] = []
    
    // Subscription para manter o Combine observando mudanças
    private var cancellables = Set<AnyCancellable>()
    
    // Primeira view a ser apresentada ao iniciar a Navegação
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }()
    
    // MARK: - INIT
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        self.rootViewController = UINavigationController()
    }
    
    // MARK: - START
    func start() {
        // Aqui define-se a primeira view a ser apresentada
        rootViewController.setViewControllers([homeViewController], animated: false)
        
        // Observando mudanças na selectedNavigation
        viewModel.$selectedNavigation
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedNavigation in
                self?.handleNavigation(selectedNavigation)
            }
            .store(in: &cancellables)
    }
    
    // MARK: - FUNÇÕES AUXILIARES
    private func handleNavigation(_ navigation: NavigationCases) {
        // Inicia a navegação dependendo do botão selecionado na Home
        switch navigation {
        case .consciousnessExam:
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
    
    private func startConsciousnessExamCoordinator() {
        let consciousnessExamCoordinator = ConsciousnessExamCoordinator()
        self.childCoordinators.append(consciousnessExamCoordinator)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.fillMode = .forwards
        transition.isRemovedOnCompletion = false
        
        self.rootViewController.view.layer.add(transition, forKey: kCATransition)
        
        consciousnessExamCoordinator.start()
        // Nesse caso, usamos o "pushViewController" pois a próxima rootViewController é uma UIViewController
        // Se fosse uma UINavigationController, usaríamos o "setViewControllers".
        self.rootViewController.pushViewController(consciousnessExamCoordinator.rootViewController, animated: false)
    }
    
    private func startLiturgicalCalendarCoordinator() {
        
    }
    
    private func startPenanceCoordinator() {
        
    }
    
    private func startTodaysSaintCoordinator() {
        
    }
    
    private func startPrayersCoordinator() {
        let prayersCoordinator = PrayersCoordinator()
        self.childCoordinators.append(prayersCoordinator)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.fillMode = .forwards
        transition.isRemovedOnCompletion = false
        
        self.rootViewController.view.layer.add(transition, forKey: kCATransition)
        
        prayersCoordinator.start()
        self.rootViewController.pushViewController(prayersCoordinator.rootViewController, animated: false)
    }
    
}
