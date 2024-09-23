//
//  DailyLiturgyViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class DailyLiturgyViewController: UIViewController {

    var viewModel: DailyLiturgyViewModel
    var label: TextComponent!
    
    init(viewModel: DailyLiturgyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        label = TextComponent()
        label.setDynamicFont(size: 20, weight: .bold)
        label.setText(string: "DAILY LITURGY VIEW")
//        label.textColor = .black
//        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
//        UILabel.setFontStyle(.textoNormal)
        
        
        constraints()
    }
    
    func constraints() {
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

}
