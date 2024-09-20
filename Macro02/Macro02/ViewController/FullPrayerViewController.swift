//
//  FullPrayerViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI

class FullPrayerViewController: UIViewController {

    @ObservedObject var viewModel: PrayersViewModel
    
    var titleText: UILabel!
    var text: UILabel!
    
    init(viewModel: PrayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        self.titleText = UILabel()
        self.text = UILabel()
        
        titleText.text = viewModel.selectedPrayer?.title
        text.text = viewModel.selectedPrayer?.text
        
        titleText.textColor = .black
        text.textColor = .black
        
        titleText.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        
        text.numberOfLines = 0
        text.lineBreakMode = .byWordWrapping
        
        titleText.translatesAutoresizingMaskIntoConstraints = false
        text.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(titleText)
        self.view.addSubview(text)
        
        constraints()
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            titleText.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleText.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            
            text.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 32),
            text.leadingAnchor.constraint(equalTo: titleText.leadingAnchor),
            text.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])
    }

}
