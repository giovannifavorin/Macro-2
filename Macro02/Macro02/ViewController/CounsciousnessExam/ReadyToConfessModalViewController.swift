//
//  ReadyToConfessModalViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 21/10/24.
//

import UIKit

class ReadyToConfessModalViewController: UIViewController {
    
    var coordinator: ConsciousnessExamCoordinator?
    private var viewModel: SinViewModel
    
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var listButton: UIButton!
    private var exitButton: UIButton!
    
    init(viewModel: SinViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLabels()
        setupButtons()
        
        setupConstraints()
    }
    
    // MARK: - LABELS
    private func setupLabels() {
        self.titleLabel = UILabel()
        titleLabel.text = "Pronto para Confessar"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.setDynamicFont(size: 36, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.descriptionLabel = UILabel()
        descriptionLabel.text = """
        Arrependo-me de todo o coração de todos os meus pecados e detesto-os, porque ao pecar, não só mereço as penas que causam.          
        """
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textAlignment = .center
        descriptionLabel.setDynamicFont(size: 18)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
    }
    
    // MARK: - BUTTONS
    private func setupButtons() {
        setupListButton()
        setupExitButton()
    }
    
    private func setupListButton() {
        self.listButton = UIButton()
        listButton.setTitle("Ver Lista de Confissão", for: .normal)
        listButton.backgroundColor = .black
        listButton.tintColor = .white
        listButton.layer.cornerRadius = view.bounds.width * 0.075
        listButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        listButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(listButton)
    }
    
    private func setupExitButton() {
        self.exitButton = UIButton()
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        
        exitButton.setImage(largeImage, for: .normal)
        exitButton.tintColor = .gray
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(exitButton)
    }
    
    // MARK: - OBJC METHODS
    @objc
    private func exit() {
        self.coordinator?.handleNavigation(.popToRoot)
        dismiss(animated: true)
    }
    
}

// MARK: - Constraints
extension ReadyToConfessModalViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            exitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: view.bounds.width * -0.05),
            exitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: view.bounds.width * 0.05),
            
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            
            descriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.bounds.height * 0.1),
            descriptionLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            listButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            listButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: view.bounds.height * -0.1),
            listButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            listButton.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
}
