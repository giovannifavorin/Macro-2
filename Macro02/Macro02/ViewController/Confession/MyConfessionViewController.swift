//
//  MyConfessionViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 23/09/24.
//

import UIKit

class MyConfessionViewController: UIViewController {

    var viewModel: ConfessionViewModel
    var label: TextComponent!
    
    init(viewModel: ConfessionViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = TextComponent("CONFESSION VIEW")
        label.font = UIFont.setCustomFont(.textoNormal)
        view.addSubview(label)
        
        view.backgroundColor = .white
        
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
