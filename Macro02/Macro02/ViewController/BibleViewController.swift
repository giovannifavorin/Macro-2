//
//  BibleViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class BibleViewController: UIViewController {

    var viewModel: BibleViewModel?
    var label: TextComponent!
    
    var coordinator: BibleCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = TextComponent("BIBLE VIEW")
        label.font = UIFont.setCustomFont(.titulo2)
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
