//
//  OnboardingViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 10/10/24.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    var coordinator: OnboardingCoordinator?
    
    var titleLbl: UILabel!
    var textLbl: UILabel!
    var button: UIButton!
    var image: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        self.button = UIButton()
        self.button.setTitle("Finalizar Onboarding", for: .normal)
        self.button.setTitleColor(.systemBlue, for: .normal)
        self.button.addTarget(self, action: #selector(finishOnboarding), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc
    private func finishOnboarding() {
        coordinator?.finishOnboarding()
    }

}
