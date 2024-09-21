//
//  PrayerOptionsModalViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI

class PrayerOptionsModalViewController: UIViewController {
    
    @ObservedObject var viewModel: PrayersViewModel
    
    var closeButton: UIButton!
    var fontSizeSlider: UISlider!
    
    init(viewModel: PrayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configurar a view de fundo
        view.backgroundColor = .white
        
        setupCloseBt()
        setupFontSlider()
        constraints()
        
    }
    
    // Configurar a altura do modal para cobrir metade da tela
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium()]  // Configura para cobrir a metade da tela
            sheet.prefersGrabberVisible = true  // Exibe a alça para arrastar o modal
        }
    }
    
    private func setupCloseBt() {
        closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.systemBlue, for: .normal)
//        closeButton.setImage(UIImage(systemName: "x.mark"), for: .normal)
//        closeButton.tintColor = .systemBlue
        closeButton.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(closeButton)
    }
    
    private func setupFontSlider() {
        fontSizeSlider = UISlider()
        fontSizeSlider.minimumValue = 12.0
        fontSizeSlider.maximumValue = 36.0
        fontSizeSlider.value = Float(viewModel.fontSize)
        
        fontSizeSlider.translatesAutoresizingMaskIntoConstraints = false
        fontSizeSlider.addTarget(self, action: #selector(fontSizeChanged), for: .valueChanged)
        
        view.addSubview(fontSizeSlider)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 32),
            closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            fontSizeSlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fontSizeSlider.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 64),
            fontSizeSlider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            fontSizeSlider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    @objc func closeModal() {
        dismiss(animated: true, completion: nil)  // Fecha o modal
    }
    
    @objc func fontSizeChanged(_ sender: UISlider) {
        viewModel.fontSize = CGFloat(sender.value)
    }
    
}
