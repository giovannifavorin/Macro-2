//
//  VerseViewController.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//

import UIKit

class VerseViewController: UIViewController {
    
    var viewModel: VerseViewModel?
    var coordinator: BibleCoordinator?
    private let textLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTextLabel()
        displayVerse()
    }
    
    private func setupTextLabel() {
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.numberOfLines = 0
        textLabel.textAlignment = .center
        view.addSubview(textLabel)
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    private func displayVerse() {
        guard let verse = viewModel?.verse else { return }
        textLabel.text = "\(verse.number): \(verse.text)"
    }
}
