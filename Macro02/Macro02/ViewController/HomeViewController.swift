//
//  HomeViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    var counsExamBt: UIButton!
    var prayersBt: UIButton!
    var label: TextComponent!
    
    var coordinator: HomeCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = TextComponent("HOME VIEW")
        label.font = UIFont.setCustomFont(.titulo1)
        
        view.addSubview(label)
        
        setupBts()
        constraints()
    }
    
    private func setupBts() {
        counsExamBt = UIButton()
        counsExamBt.setTitle("Counsciousness Exam", for: .normal)
        counsExamBt.setTitleColor(.systemBlue, for: .normal)
        counsExamBt.addTarget(self, action: #selector(navigateToCounsciousnessExam), for: .touchUpInside)
        counsExamBt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(counsExamBt)
        
        prayersBt = UIButton()
        prayersBt.setTitle("Prayers", for: .normal)
        prayersBt.setTitleColor(.systemBlue, for: .normal)
        prayersBt.addTarget(self, action: #selector(navigateToPrayers), for: .touchUpInside)
        prayersBt.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(prayersBt)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            counsExamBt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            counsExamBt.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            
            prayersBt.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            prayersBt.topAnchor.constraint(equalTo: counsExamBt.bottomAnchor, constant: 8)
        ])
    }
    
    // MARK: - Navigation #selector methods
    // Um método de navegação para cada caso na tela Home
    @objc private func navigateToCounsciousnessExam() {
        self.coordinator?.handleNavigation(.counsciousnessExam)
    }
    
    @objc private func navigateToPrayers() {
        self.coordinator?.handleNavigation(.prayers)
    }
}
