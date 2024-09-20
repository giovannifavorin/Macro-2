//
//  HomeCoordinator.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit
import Combine

class HomeCoordinator: Coordinator {
    
    var rootViewController: UINavigationController
    var viewModel = HomeViewModel()
    
    var childCoordinators: [Coordinator] = []
    
    // Subscription para manter o Combine observando mudanças
    private var cancellables = Set<AnyCancellable>()
    
    lazy var homeViewController: HomeViewController = {
        let vc = HomeViewController(viewModel: viewModel)
        return vc
    }()
    
    init() {
        self.rootViewController = UINavigationController()
//        self.rootViewController.navigationBar.isTranslucent = true
    }
    
    func start() {
        rootViewController.setViewControllers([homeViewController], animated: false)
        
        // Observando mudanças na selectedNavigation
        viewModel.$selectedNavigation
            .receive(on: RunLoop.main)
            .sink { [weak self] selectedNavigation in
                self?.handleNavigation(selectedNavigation)
            }
            .store(in: &cancellables)
    }
    
    private func handleNavigation(_ navigation: NavigationCases) {
        switch navigation {
        case .counsciousnessExam:
            startCounsciousnessExamCoordinator()
            
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
    
    private func startCounsciousnessExamCoordinator() {
        let counsciousnessExamCoordinator = CounsciousnessExamCoordinator()
        self.childCoordinators.append(counsciousnessExamCoordinator)
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        transition.fillMode = .forwards
        transition.isRemovedOnCompletion = false
        
        self.rootViewController.view.layer.add(transition, forKey: kCATransition)
        
        counsciousnessExamCoordinator.start()
        // Nesse caso, usamos o "pushViewController" pois a próxima rootViewController é uma UIViewController
        // Se fosse uma UINavigationController, usaríamos o "setViewControllers".
        self.rootViewController.pushViewController(counsciousnessExamCoordinator.rootViewController, animated: false)
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
