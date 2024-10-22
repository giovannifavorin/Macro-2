//
//  ConfessionAuthViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class ConfessionAuthViewController: UIViewController {
    
    var authManager: AuthManager
    var viewModel: SinViewModel
    var coordinator: ConfessionCoordinator?
    var confessionAuthView: ConfessionAuthView!
    
    init(authManager: AuthManager, viewModel: SinViewModel) {
        self.authManager = authManager
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        confessionAuthView = ConfessionAuthView(frame: self.view.bounds)
        confessionAuthView.configureButtonTarget(self, action: #selector(didTapButton))
        
        self.view.addSubview(confessionAuthView)
    }
    
    @objc private func didTapButton() {
        authManager.authenticateWithFaceID()
    }
}

class ConfessionAuthView: UIView {
    
    var label: UILabel!
    var button: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLabel()
        setupButton()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLabel() {
        label = UILabel()
        label.text = "CONFESSION VIEW"
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
    }
    
    private func setupButton() {
        button = UIButton()
        button.setTitle("Authorize", for: .normal)
        button.backgroundColor = .darkGray
        button.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(button)
    }
    
    func configureButtonTarget(_ target: Any, action: Selector) {
        button.addTarget(target, action: action, for: .touchUpInside)
    }
}

/// Extensions com constraints
extension ConfessionAuthView {
    /// func com constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            button.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
