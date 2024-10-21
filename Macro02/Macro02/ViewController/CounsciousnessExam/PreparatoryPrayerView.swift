//
//  PreparatoryPrayerView.swift
//  Macro02
//
//  Created by Victor Dantas on 16/10/24.
//

import UIKit

class PreparatoryPrayerViewController: UIViewController {
    
    weak var coordinator: ConsciousnessExamCoordinator?
    
    // Componentes principais
    let progressBar = ProgressBarUI(index: 1)
    let titleLabel = UILabel()
    let closeButton = UIButton()
    let smallTextLabel = UILabel()
    let prayerTextLabel = UILabel()
    let backButton = UIButton()
    let nextButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupProgressBar()
        setupTitleLabel()
        setupCloseButton()
        setupSmallTextLabel()
        setupPrayerTextLabel()
        setupBackButton()
        setupNextButton()
        
        setupConstraints()
    }
    
    // Configura a barra de progresso
    private func setupProgressBar() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
    }
    
    // Configura o título
    private func setupTitleLabel() {
        titleLabel.text = "Oração Preparatória"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
    }
    
    // Configura o botão de fechar (X)
    private func setupCloseButton() {
        // Defina a imagem do sistema e aumente seu tamanho
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold, scale: .large)
        let largeImage = UIImage(systemName: "xmark", withConfiguration: largeConfig)
        
        closeButton.setImage(largeImage, for: .normal)
        closeButton.tintColor = .gray
        closeButton.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(closeButton)
    }
    
    // Configura o texto pequeno
    private func setupSmallTextLabel() {
        smallTextLabel.text = "Oração para fazer uma boa confissão"
        smallTextLabel.font = UIFont.systemFont(ofSize: 18)
        smallTextLabel.textColor = .gray
        smallTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(smallTextLabel)
    }
    
    // Configura o texto de oração
    private func setupPrayerTextLabel() {
        // Cria um estilo de parágrafo para definir o espaçamento entre linhas
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // Define o espaçamento entre as linhas

        // Cria um texto com atributos, incluindo o espaçamento de linha e a fonte
        let attributedText = NSAttributedString(string: """
        “Senhor, iluminai-me para me observar como Vós me observas, e dai-me a graça de me arrepender verdadeira e efetivamente dos meus pecados. Ó, Virgem Santíssima, ajudai-me a fazer uma boa confissão.”
        """, attributes: [
            // Aplica o estilo de parágrafo com o espaçamento de linhas configurado acima
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 20)
        ])
        
        prayerTextLabel.attributedText = attributedText
        prayerTextLabel.numberOfLines = 0
        prayerTextLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(prayerTextLabel)
    }
    
    // Configura o botão "Back"
    private func setupBackButton() {
        backButton.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backButton.backgroundColor = .black
        backButton.tintColor = .white
        backButton.layer.cornerRadius = view.bounds.width * 0.075
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(backButton)
    }
    
    // Configura o botão "Next"
    private func setupNextButton() {
        nextButton.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        nextButton.backgroundColor = .black
        nextButton.tintColor = .white
        nextButton.layer.cornerRadius = view.bounds.width * 0.075
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nextButton)
    }
    
    // Ações dos botões
    @objc private func closeButtonTapped() {
        coordinator?.handleNavigation(.popToRoot)
    }
    
    @objc private func backButtonTapped() {
        coordinator?.handleNavigation(.back)
    }
    
    @objc private func nextButtonTapped() {
        coordinator?.handleNavigation(.consciousnessExamFirst)
    }
    
    // Configura as constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            // Barra de progresso no topo
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            progressBar.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: view.bounds.width * 0.05),
            progressBar.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: view.bounds.width * -0.05),
            progressBar.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.01),
            
            // Título
            titleLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.height * 0.05),
            titleLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            titleLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6),
            
            // Botão de fechar (X)
            closeButton.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            closeButton.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            closeButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.05),
            closeButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.05),
            
            // Texto pequeno
            smallTextLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: view.bounds.height * 0.035),
            smallTextLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            
            // Texto de oração
            prayerTextLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.width * 0.45),
            prayerTextLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            prayerTextLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            
            // Botão "Back"
            backButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backButton.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01),
            
            // Botão "Next"
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextButton.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01)
        ])
    }
}
