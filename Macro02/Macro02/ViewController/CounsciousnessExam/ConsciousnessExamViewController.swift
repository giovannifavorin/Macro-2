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
    
    var viewModel: SinViewModel?
    var coordinator: ConsciousnessExamCoordinator?
    
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
        viewModel?.fetchSavedSins()
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
        //verify if the textfield is not Empty
        guard let newSin = sinTextField.text, !newSin.isEmpty else {
            // If empty, does Nothing
            return
        }
        
        //Create a UIAlertController para escolher uma categoria
        let alertController = UIAlertController(title: "Choose a category", message: "You can choose a category to add a sin or create a new one", preferredStyle: .alert)
        
        //botao pra escolher a Categoria Existente
        alertController.addAction(UIAlertAction(title: "Existing Category", style: .default, handler: { _ in
            self.chooseExistingCategory(for: newSin)
        }))
        
        //Botao para criar uma nova categoria
        alertController.addAction(UIAlertAction(title: "New Category", style: .default, handler: { _ in
            self.addNewCategory(for: newSin)
        }))
        
        //botao para cancelar
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //Apresentar o UIAlertController
        present(alertController, animated: true, completion: nil)
        
        //Clean Text Field
        sinTextField.text = ""
    }
    
    private func chooseExistingCategory(for newSin: String) {
        
        guard let viewModel = viewModel else { return }
        
        // Criar um UIAlertController com as opções de categorias
        let cateforyAlertController = UIAlertController(title: "Choose a category", message: "You can choose a category to add a sin or create a new one", preferredStyle: .alert)
        
        //Adiciona uma opcao para cada categoria existente
        for commandment in viewModel.commandments {
            cateforyAlertController.addAction(UIAlertAction(title: commandment.title, style: .default, handler: { _ in
                self.addSinToCategory(newSin, categoryTitle: commandment.title)
            }))
        }
        // Apresentar o UIAlertController
        present(cateforyAlertController, animated: true, completion: nil)
    }
    
    
    //Func to add sin to existing category
    private func addSinToCategory(_ newSin: String, categoryTitle: String) {
        
        guard let viewModel = viewModel else { return }
        
        //Encontrar a categoria correspondente para add o pecado
        if let index = viewModel.commandments.firstIndex(where: {$0.title == categoryTitle}) {
            viewModel.commandments[index].sins.append(newSin)
            tableView.reloadData()
            
            //Scroll to the last line added
            let lastIndexPath = IndexPath(row: viewModel.commandments[index].sins.count - 1, section: index)
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }
    }
    
    private func addNewCategory(for newSin: String) {
        // Criar um UIAlertController para inserir o título e descrição da nova categoria
        let newCategoryAlertController = UIAlertController(title: "New category", message: "Enter a title for the new category", preferredStyle: .alert)
        
        // Adicionar um campo de texto para o título da categoria
        newCategoryAlertController.addTextField { textField in
            textField.placeholder = "Category Title"
        }
        
        // Adicionar um campo de texto para a descrição da categoria
        newCategoryAlertController.addTextField { textField in
            textField.placeholder = "Category Description"
        }
        
        // Botão para criar a nova categoria
        newCategoryAlertController.addAction(UIAlertAction(title: "Create", style: .default, handler: { [weak self] _ in
            guard let title = newCategoryAlertController.textFields?.first?.text, !title.isEmpty,
                  let description = newCategoryAlertController.textFields?[1].text, !description.isEmpty else {
                return // Se os campos estiverem vazios, não faz nada
            }
            
            guard let viewModel = self?.viewModel else { return }
            
            //cria yma nova categoria com o pecado adicionado
            let newCommandment = Commandment(title: title, description: description, sins: [newSin])
            viewModel.commandments.append(newCommandment)
            
            //reload table
            self?.tableView.reloadData()
            
            //Scroll para a nova seção (última seção)
            let lastSectionIndex = (viewModel.commandments.count) - 1
            let lastIndexPath = IndexPath(row: 0, section: lastSectionIndex)
            self?.tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
        }))
        
        //botao de cancelar
        newCategoryAlertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        //apresentar o UIAlertController
        present(newCategoryAlertController, animated: true, completion: nil)
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
