//
//  ConfessionViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class ConfessionViewController: UIViewController {
    
    var viewModel: ConfessionViewModel
    var label: UILabel!
    
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
        label = UILabel()
        label.text = "CONFESSION VIEW"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
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
