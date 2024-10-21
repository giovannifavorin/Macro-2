//
//  MyConfessionViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 23/09/24.
//

import UIKit

class MyConfessionViewController: UIViewController {
    
    
    var authManager: AuthManager
    var viewModel: SinViewModel
    var tableView: UITableView!
    var sins: [Sin] = []
    
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
        
        view.backgroundColor = .white
        
        setupTableView()
        constraints()
        loadSins()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadSins()  // Atualiza os dados sempre que a tela aparecer
    }
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "SinCell")
        
        view.addSubview(tableView)
    }
    
    private func constraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func loadSins() {
        sins = DataManager.shared.fetchAllCommittedSins()
        tableView.reloadData()
    }
}

extension MyConfessionViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SinCell", for: indexPath)
        let sin = sins[indexPath.row]
        cell.textLabel?.text = sin.sinDescription
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Implementar ação de seleção, se necessário
    }
}



public func printAllCommittedSins() {
    let committedSins = DataManager.shared.fetchAllCommittedSins()
    
    for (index, sin) in committedSins.enumerated() {
        print("Pecado \(index + 1):")
        print("  Mandamento: \(sin.commandments ?? "N/A")")
        print("  Descrição do Mandamento: \(sin.commandmentDescription ?? "N/A")")
        print("  Descrição do Pecado: \(sin.sinDescription ?? "N/A")")
        print("–––––––––––––––––––––––")
    }
}
