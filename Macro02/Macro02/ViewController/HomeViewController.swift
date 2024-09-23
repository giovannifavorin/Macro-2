//
//  HomeViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel
    var label: TextComponent!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = TextComponent("HOME VIEW")
        label.font = UIFont.setCustomFont(.titulo1)
        
        view.addSubview(label)
        
        constraints()
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
