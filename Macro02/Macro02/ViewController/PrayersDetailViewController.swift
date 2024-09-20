//
//  PrayersDetailViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

import UIKit
import SwiftUI

class PrayersDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @ObservedObject var viewModel: PrayersViewModel
    
    var tableView: UITableView!
    var prayers: [Prayer]!
    
//    lazy var selectedCategory: PrayerCategory = {
//        if let selectedCategory = viewModel.selectedCategory {
//            return selectedCategory
//        }
//        return selectedCategory
//    }()
    
    init(viewModel: PrayersViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCategory = viewModel.selectedCategory {
            self.prayers = selectedCategory.prayers
        }
        

        self.view.backgroundColor = .brown
        
        tableView = UITableView(frame: view.bounds)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrayersCell")
        view.addSubview(tableView)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if prayers != nil {
            return prayers.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayersCell", for: indexPath)
        
        if prayers != nil {
            let prayer = prayers[indexPath.row]
            
            // Configura o texto e a imagem da célula
            cell.textLabel?.text = prayer.title
            
            return cell
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPrayer = prayers[indexPath.row]
        viewModel.selectedPrayer = selectedPrayer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

}
