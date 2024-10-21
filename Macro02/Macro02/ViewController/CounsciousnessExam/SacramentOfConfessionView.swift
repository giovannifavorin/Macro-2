//
//  SacramentOfConfessionViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 16/10/24.
//

import UIKit

class SacramentOfConfessionViewController: UIViewController {
    
    var coordinator: ConsciousnessExamCoordinator?
    
    // Componentes principais
    let progressBar = ProgressBarUI(index: 0)
    let titleLabel = UILabel()
    let closeButton = UIButton()
    let prayerTextLabel = UILabel()
    let nextButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupProgressBar()
        setupTitleLabel()
        setupCloseButton()
        setupPrayerTextLabel()
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
        titleLabel.text = "Sacramento da Confissão"
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
    
    // Configura o texto de oração
    private func setupPrayerTextLabel() {
        // Cria um estilo de parágrafo para definir o espaçamento entre linhas
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // Define o espaçamento entre as linhas

        // Cria um texto com atributos, incluindo o espaçamento de linha e a fonte
        let attributedText = NSAttributedString(string: """
        No momento do sacramento da reconciliação – ou confissão –, somos convidados a reconhecer nossos pecados e rezar o ato de contrição diante do Senhor.

        Às vezes temos dificuldades de reconhecer nossos pecados. Rezar antes de realizar a confissão pode nos ajudar.
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
    
    @objc private func nextButtonTapped() {
        coordinator?.handleNavigation(.preparatoryPrayer)
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
            
            // Texto de oração
            prayerTextLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.width * 0.45),
            prayerTextLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            prayerTextLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            
            // Botão "Next"
            nextButton.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextButton.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01)
        ])
    }
}
