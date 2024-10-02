//
//  ConsciousnessExamViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 19/09/24.
//

import UIKit
import SwiftUI

class ConsciousnessExamViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    private let tableView = UITableView()
    private let viewModel = SinViewModel()
    
    //Text Input para adicionar Pecado
    private let sinTextField: UITextField = {
        let textInput = UITextField()
        textInput.placeholder = "Escreva o pecado"
        textInput.borderStyle = .roundedRect
        return textInput
    }()
    
    //Botao para Submeter o Texto
    private let sinSubmitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Adicionar", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Exame de Consciência"
        
        setupTableView()
        setupTableFooterView()
        
//        //add gesture to Hide keyboard when touch outside
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
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
        return viewModel.commandments.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.commandments[section].questions.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.commandments[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionCell", for: indexPath)
        let commandment = viewModel.commandments[indexPath.section]
        let question = commandment.questions[indexPath.row]
        
        // Verifica se a pergunta já está marcada como pecado para alterar a cor da célula
        if viewModel.isQuestionMarkedAsSin(question: question) {
            cell.textLabel?.textColor = .systemRed // Pergunta marcada como pecado
        } else {
            cell.textLabel?.textColor = .systemGray // Pergunta normal
        }
        
        cell.textLabel?.text = question
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let commandment = viewModel.commandments[indexPath.section]
        let question = commandment.questions[indexPath.row]
        
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
        
        // Atualiza a célula para refletir a mudança
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    // Função para exibir alertas
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    private func setupTableFooterView() {
        //Create a ContainerView to textfield and button
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
        
        footerView.addSubview(sinTextField)
        footerView.addSubview(sinSubmitButton)
        
        //delegate to dismiss
        sinTextField.delegate = self
        
        //autolayout to the textfield insede the foorterView
        sinTextField.translatesAutoresizingMaskIntoConstraints = false
        sinSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sinTextField.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 16),
            sinTextField.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -16),
            sinTextField.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 8),
            sinTextField.heightAnchor.constraint(equalToConstant: 40),
            
            sinSubmitButton.topAnchor.constraint(equalTo: sinTextField.bottomAnchor, constant: 8),
            sinSubmitButton.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            sinSubmitButton.heightAnchor.constraint(equalToConstant: 40),
            sinSubmitButton.widthAnchor.constraint(equalToConstant: 100)
        ])
        // Definir a view de rodapé da tableView
        tableView.tableFooterView = footerView
        
        // Adicionar ação ao botão
        sinSubmitButton.addTarget(self, action: #selector(addSin), for: .touchUpInside)
    }
    
    @objc private func addSin() {
        guard let newSin = sinTextField.text, !newSin.isEmpty else {
            // Se o campo estiver vazio, não faz nada
            return
        }
        viewModel.commandments[0].questions.append(newSin)
        
        //Clean Text Field
        sinTextField.text = ""
        
        //reload table to show new Sin
        tableView.reloadData()
        
        //Scroll to the last line added
        let lastIndexPath = IndexPath(row: viewModel.commandments[0].questions.count - 1, section: 0)
        tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Oculta o teclado ao pressionar "Return"
        return true
    }
}
