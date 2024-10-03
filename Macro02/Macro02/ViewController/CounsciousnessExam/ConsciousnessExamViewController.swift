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
        textInput.placeholder = "Anotate your sins here."
        textInput.borderStyle = .roundedRect
        return textInput
    }()
    
    //Botao para Submeter o Texto
    private let sinSubmitButton: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Conciousness Exam"
        
        setupTableView()
        setupTableFooterView()
        
        setupKeyboard()
        setupTapGesture()
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
    
    
    //MARK: ADD sin texfield And Label
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
        // Define the footer View of tableview
        tableView.tableFooterView = footerView
        
        // Add Action to Button
        sinSubmitButton.addTarget(self, action: #selector(addSin), for: .touchUpInside)
    }
    
    @objc private func addSin() {
        guard let newSin = sinTextField.text, !newSin.isEmpty else {
            // If empty, does Nothing
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
    
    //MARK: Keyboard Functions
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0)
            tableView.contentInset = contentInsets
            tableView.scrollIndicatorInsets = contentInsets
            
            // Se quiser que o TextField esteja visível ao aparecer o teclado
            if let activeField = tableView.tableFooterView {
                let visibleRect = self.view.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight, right: 0))
                if !visibleRect.contains(activeField.frame.origin) {
                    tableView.scrollRectToVisible(activeField.frame, animated: true)
                }
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    //Dissmiss the keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //Observe keyboard notifications
    private func setupKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //Remove the observers from Keyboard
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //add gesture to Hide keyboard when touch outside
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    //Hide Keyboard when return is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
