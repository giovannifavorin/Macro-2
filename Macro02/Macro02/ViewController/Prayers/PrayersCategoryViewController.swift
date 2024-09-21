//
//  PrayersViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI

class PrayersCategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @ObservedObject var viewModel: PrayersViewModel
    
    var tableView: UITableView!
    var prayerCategories: [PrayerCategory]!
    
    init(viewModel: PrayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prayerCategories = viewModel.prayerCategories

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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCategory = prayerCategories[indexPath.row]
        viewModel.selectedCategory = selectedCategory
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
