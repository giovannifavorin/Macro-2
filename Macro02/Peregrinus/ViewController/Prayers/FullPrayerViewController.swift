//
//  FullPrayerViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI
import Combine

class FullPrayerViewController: UIViewController {
    
    @ObservedObject var viewModel: PrayersViewModel
    var coordinator: PrayersCoordinator?
    
    var prayerTitle: UILabel!
    var prayerText: UILabel!
    var optionsBt: UIBarButtonItem!
    
    var prayer: Prayer
    
    var cancellables = Set<AnyCancellable>()
    
    init(viewModel: PrayersViewModel, prayer: Prayer) {
        self.viewModel = viewModel
        self.prayer = prayer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLabels()
        setupOptionsButton()
        constraints()
        
        self.viewModel.$fontSize
            .receive(on: RunLoop.main)
            .sink { [weak self] newSize in
                self?.updateFontSize(newSize)
            }
            .store(in: &cancellables)
        
    }
    
    private func setupLabels() {
        
        self.prayerTitle = UILabel()
        self.prayerText = UILabel()
        
        prayerTitle.text = prayer.title
        prayerText.text = prayer.content
        
        prayerTitle.textColor = .black
        prayerText.textColor = .black
        
        prayerTitle.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        prayerText.numberOfLines = 0
        prayerText.lineBreakMode = .byWordWrapping
        
        prayerTitle.translatesAutoresizingMaskIntoConstraints = false
        prayerText.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(prayerTitle)
        self.view.addSubview(prayerText)
    }
    
    private func setupOptionsButton() {
        
        self.optionsBt = UIBarButtonItem(title: "Aa", style: .plain, target: self, action: #selector(openOptionsModal))
        
        navigationItem.rightBarButtonItem = optionsBt
        
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            prayerTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            prayerTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            prayerText.topAnchor.constraint(equalTo: prayerTitle.bottomAnchor, constant: 32),
            prayerText.leadingAnchor.constraint(equalTo: prayerTitle.leadingAnchor),
            prayerText.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
    
    // Método para atualizar o tamanho da fonte das labels
    private func updateFontSize(_ newSize: CGFloat) {
        prayerText.font = UIFont.systemFont(ofSize: newSize)
    }
    
    
    @objc private func openOptionsModal() {
        self.coordinator?.navigateToModal(vc: self)
    }
    
}
