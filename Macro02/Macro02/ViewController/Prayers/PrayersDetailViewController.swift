//
//  PrayersDetailViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI

// TODO: Ver o que fazer nessa viewController -- Navegação das orações -- entrar nas orações da categoria selecionada
class PrayersDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: PrayersViewModel
    var category: PrayerCategory
    var tableView: UITableView!
    var prayers: [Prayer]
    
    var coordinator: PrayersCoordinator?
    
    init(viewModel: PrayersViewModel, category: PrayerCategory) {
        self.viewModel = viewModel
        self.category = category
        self.prayers = category.prayers
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prayers = category.prayers
        
        

        self.view.backgroundColor = .brown
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrayersCell")
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayersCell", for: indexPath)
        
        let prayer = prayers[indexPath.row]
        
        // Configura o texto e a imagem da célula
        cell.textLabel?.text = prayer.title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let coordinator = self.coordinator {
            coordinator.navigateToFull(prayer: prayers[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
