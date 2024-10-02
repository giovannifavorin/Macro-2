//
//  PreparatoryPrayerViewController.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 02/10/24.
//

import Foundation
import UIKit

class PreparatoryPrayerViewController: UIViewController {

    var viewModel: AboutViewModel
    var label: TextComponent!
    
    init(viewModel: AboutViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        label = TextComponent("PREPARATORY PRAYER")
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

