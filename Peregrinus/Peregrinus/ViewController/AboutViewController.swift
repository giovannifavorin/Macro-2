//
//  AboutViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class AboutViewController: UIViewController {

    var viewModel: AboutViewModel?
    var label: TextComponent!
    
    var coordinator: AboutCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = TextComponent("ABOUT VIEW")
        view.addSubview(label)
        
        constraints()
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
