//
//  PrayersViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

//import UIKit
import SwiftUI

class PrayersCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var viewModel: PrayersViewModel?
    var coordinator: PrayersCoordinator?
    
    var tableView: UITableView!
    var prayerCategories: [PrayerCategory]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            self.prayerCategories = viewModel.prayerCategories
        }

        self.view.backgroundColor = .red
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrayerCategoryCell")
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayerCategories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerCategoryCell", for: indexPath)
        let category = prayerCategories[indexPath.row]
        
        // Configura o texto e a imagem da célula
        cell.textLabel?.text = category.name
        cell.imageView?.image = category.image
        
        return cell
    }
    
    // Chamada quando uma Row é selecionada
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.coordinator?.navigateToDetail(category: prayerCategories[indexPath.row])
        
    }
    
    // Altura da linha
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
