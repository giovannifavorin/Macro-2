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

}

extension MyConfessionViewController: UITableViewDataSource, UITableViewDelegate {
    
    // Retorna o número de pecados salvos
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.savedSins.count
    }
    
    // Configura a célula com a descrição do pecado
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SinCell", for: indexPath)
        let sin = viewModel.savedSins[indexPath.row]
        cell.textLabel?.text = sin.sinDescription
        return cell
    }
    
    // Se você quiser implementar alguma ação ao selecionar uma célula
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Implementar ação de seleção, se necessário
    }
}
