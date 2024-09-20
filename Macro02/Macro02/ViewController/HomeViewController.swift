//
//  HomeViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 17/09/24.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    
    @ObservedObject var viewModel: HomeViewModel
    var label: UILabel!
    var button: UIButton!
    
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
        label = UILabel()
        label.text = "HOME VIEW"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        button = UIButton()
        button.setTitle("Counsciousness Exam", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(navigateToCounsciousnessExam), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 8)
        ])
    }
    
    // MARK: - Navigation #selector methods
    @objc private func navigateToCounsciousnessExam() {
        self.viewModel.selectedNavigation = .counsciousnessExam
    }
}
