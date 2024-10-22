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
        
        // Registrar a célula personalizada
        tableView.register(PrayerCell.self, forCellReuseIdentifier: "PrayerCell")
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrayerCell", for: indexPath) as! PrayerCell
        
        let prayer = prayers[indexPath.row]
        
        // Configura o texto da célula
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

class PrayerCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Configuração da célula
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.borderWidth = 2
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.clipsToBounds = true
        
        // Configuração do padding
        self.contentView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // Ajusta o frame da célula para ocupar toda a largura da tela
        self.contentView.frame = self.bounds.insetBy(dx: 5, dy: 5) // Adiciona espaço entre as células
    }
}
