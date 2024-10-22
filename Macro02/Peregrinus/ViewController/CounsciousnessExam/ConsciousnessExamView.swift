//
//  ConsciousnessExamView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 10/10/2024.
//

//import SwiftUI
import UIKit

class ConsciousnessExamView: UIView{
    
    //MARK: Subviews
    let tableView = UITableView()
    
    let sinTextField: UITextField = {     //Text Input para adicionar Pecado
        let textInput = UITextField()
        textInput.placeholder = "Anotate your sins here."
        textInput.borderStyle = .roundedRect
        return textInput
    }()
    
    let sinSubmitButton: UIButton = {    //Botao para Submeter o Texto
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        return button
    }()
    
    //Inicializador
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView(){
        backgroundColor = .white
        
        //Add Subviews
        addSubview(tableView)
        addSubview(sinTextField)
        addSubview(sinSubmitButton)
        
        //Auto Layout Setup
        setupConstraints()
        
    }
    
    private func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        sinTextField.translatesAutoresizingMaskIntoConstraints = false
        sinSubmitButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    func setupTableFooterView() {
        //Create a ContainerView to textfield and button
        let footerView = UIView()
        footerView.frame = CGRect(x: 0, y: 0, width: frame.width, height: 100)
        
        // Adicione os subviews usando consciousnessExamView
        footerView.addSubview(sinTextField)
        footerView.addSubview(sinSubmitButton)
        
        
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
        }
    
}

