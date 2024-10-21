//
//  ActOfContritionFirstViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 21/10/24.
//

import UIKit

class ActOfContritionFirstViewController: UIViewController {
    
    weak var coordinator: ConsciousnessExamCoordinator?
    var viewModel: SinViewModel?
    
    // Componentes principais
    var titleLabel = UILabel()
    var descriptionLabel = UILabel()
    var backBt = UIButton()
    var nextBt = UIButton()
    var progressBar: UIView!
    var closeButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationItem.hidesBackButton = true

        setupProgressBar()
        setupTitleLabel()
        setupCloseButton()
        setupDescriptionLabel()
        setupButtons()
        
        setupConstraints()
    }
    
    // Configura a barra de progresso
    private func setupProgressBar() {
        self.progressBar = ProgressBarUI(index: 3)
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(progressBar)
    }
    
    // Configura o título
    private func setupTitleLabel() {
        titleLabel.text = "Ato de Contrição"
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
    
    // Configura o texto descritivo
    private func setupDescriptionLabel() {
        // Cria um estilo de parágrafo para definir o espaçamento entre linhas
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10 // Define o espaçamento entre as linhas

        // Cria um texto com atributos, incluindo o espaçamento de linha e a fonte
        let attributedText = NSAttributedString(string: """
        O arrependimento, é uma dor da alma e uma rejeição dos nossos pecados, que inclui a resolução de não voltar a pecar. É um dom de Deus
        """, attributes: [
            // Aplica o estilo de parágrafo com o espaçamento de linhas configurado acima
            .paragraphStyle: paragraphStyle,
            .font: UIFont.systemFont(ofSize: 20)
        ])
        
        descriptionLabel.attributedText = attributedText
        descriptionLabel.numberOfLines = 0
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(descriptionLabel)
    }
    
    // Configura os botões "Back" e "Next"
    private func setupButtons() {
        backBt.setImage(UIImage(systemName: "arrow.left"), for: .normal)
        backBt.backgroundColor = .black
        backBt.tintColor = .white
        backBt.layer.cornerRadius = view.bounds.width * 0.075
        backBt.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backBt.translatesAutoresizingMaskIntoConstraints = false
        
        nextBt.setImage(UIImage(systemName: "arrow.right"), for: .normal)
        nextBt.backgroundColor = .black
        nextBt.tintColor = .white
        nextBt.layer.cornerRadius = view.bounds.width * 0.075
        nextBt.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        nextBt.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(backBt)
        view.addSubview(nextBt)
    }
    
    // Ação para fechar a view (X)
    @objc private func closeButtonTapped() {
        coordinator?.handleNavigation(.popToRoot)
    }
    
    // Ação para voltar
    @objc private func goBack() {
        coordinator?.handleNavigation(.back)
    }
    
    // Ação para avançar
    @objc private func goForward() {
        coordinator?.handleNavigation(.actOfContritionSecond)
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
            descriptionLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: view.bounds.width * 0.45),
            descriptionLabel.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            
            // Botão "Back"
            backBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            backBt.leadingAnchor.constraint(equalTo: progressBar.leadingAnchor),
            backBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01),
            
            // Botão "Next"
            nextBt.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextBt.heightAnchor.constraint(equalToConstant: view.bounds.width * 0.15),
            nextBt.trailingAnchor.constraint(equalTo: progressBar.trailingAnchor),
            nextBt.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: view.bounds.height * -0.01)
        ])
    }
}
