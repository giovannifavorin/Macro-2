//
//  HomeViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {

    var homeView: HomeView!
    var coordinator: HomeCoordinator?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeView = HomeView(frame: self.view.bounds)
        homeView.configureButtonTargets(self, consciousnessSelector: #selector(navigateToConsciousnessExam), prayersSelector: #selector(navigateToPrayers))
        
        self.view.addSubview(homeView)
    }
    
    @objc private func navigateToConsciousnessExam() {
        self.coordinator?.handleNavigation(.consciousnessExam)
    }
    
    @objc private func navigateToPrayers() {
        self.coordinator?.handleNavigation(.prayers)
    }
}

class HomeView: UIView {
    
    var counsExamBt: UIButton!
    var prayersBt: UIButton!
    var label: TextComponent!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupLabel()
        setupBts()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        label = TextComponent("HOME VIEW")
        label.font = UIFont.setCustomFont(.titulo1)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
    }
    
    private func setupBts() {
        counsExamBt = UIButton()
        counsExamBt.setTitle("Consciousness Exam", for: .normal)
        counsExamBt.setTitleColor(.systemBlue, for: .normal)
        counsExamBt.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(counsExamBt)
        
        prayersBt = UIButton()
        prayersBt.setTitle("Prayers", for: .normal)
        prayersBt.setTitleColor(.systemBlue, for: .normal)
        prayersBt.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(prayersBt)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            counsExamBt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            counsExamBt.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            
            prayersBt.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            prayersBt.topAnchor.constraint(equalTo: counsExamBt.bottomAnchor, constant: 8)
        ])
    }
    
    func configureButtonTargets(_ target: Any, consciousnessSelector: Selector, prayersSelector: Selector) {
        counsExamBt.addTarget(target, action: consciousnessSelector, for: .touchUpInside)
        prayersBt.addTarget(target, action: prayersSelector, for: .touchUpInside)
    }
}
