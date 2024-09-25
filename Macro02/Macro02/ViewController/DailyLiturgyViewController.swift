//
//  DailyLiturgyViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class DailyLiturgyViewController: UIViewController {

    var viewModel: DailyLiturgyViewModel
    var label: TextComponent!
    var button: ButtonComponent!
    
    init(viewModel: DailyLiturgyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        label = TextComponent("OK TEXTO")
        label.font = UIFont.setCustomFont(.textoDetalhe)
        
        button = ButtonComponent("Clique em mim e eu clicarei de volta") {
            print("Eu fui clicado")
        }

        view.addSubview(label)
        view.addSubview(button)
        
        constraints()
    }

    func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
        ])
    }

}
