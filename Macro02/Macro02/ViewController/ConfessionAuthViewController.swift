//
//  ConfessionAuthViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class ConfessionAuthViewController: UIViewController {
    
    var viewModel: ConfessionViewModel?
    var coordinator: ConfessionCoordinator?
    
    var label: UILabel!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        label = UILabel()
        label.text = "CONFESSION VIEW"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        setupBt()
        constraints()
    }
    
    private func setupBt() {
        self.button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        button.center = view.center
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .darkGray
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    @objc private func didTapButton() {
        if let viewModel = viewModel {
            viewModel.authenticateWithFaceID()
        }
    }

}
