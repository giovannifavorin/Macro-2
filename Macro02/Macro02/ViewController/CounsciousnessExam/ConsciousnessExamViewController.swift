//
//  ConsciousnessExamViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit
import SwiftUI

class ConsciousnessExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView = UITableView()
    
    var viewModel: SinViewModel?
    var coordinator: CounsciousnessExamCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Exame de Consciência"
        
        setupTableView()
        viewModel?.fetchSavedSins()
    }
    
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "QuestionCell")
        view.addSubview(tableView)
        
        // Configurar constraints (auto layout)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.commandments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.commandments[section].sins.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return "" }
        return viewModel.commandments[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let viewModel = viewModel {
            let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
            let commandment = viewModel.commandments[indexPath.section]
            let question = commandment.sins[indexPath.row]
            
            // Verifica se a pergunta já está marcada como pecado para alterar a cor da célula
            if viewModel.isQuestionMarkedAsSin(question: question) {
                cell.textLabel?.textColor = .systemRed // Pergunta marcada como pecado
            } else {
                cell.textLabel?.textColor = .systemGray // Pergunta normal
            }
            
            cell.textLabel?.text = question
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let viewModel = viewModel {
            let commandment = viewModel.commandments[indexPath.section]
            let question = commandment.sins[indexPath.row]
            
            // Verifica se a pergunta já está marcada como pecado
            if viewModel.isQuestionMarkedAsSin(question: question) {
                // Desmarcar como pecado
                viewModel.unmarkAsSin(question: question)
                showAlert(title: "Pecado Desmarcado", message: "Você desmarcou: \(question)")
            } else {
                // Marcar como pecado
                viewModel.markAsSin(question: question)
                showAlert(title: "Pecado Marcado", message: "Você marcou: \(question)")
            }
        }
        
        // Atualiza a célula para refletir a mudança
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // Função para exibir alertas
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
