//
//  AboutViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class AboutViewController: UIViewController {

    var viewModel: AboutViewModel
    var label: UILabel!
    
    init(viewModel: AboutViewModel) {
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
        label.text = "ABOUT VIEW"
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