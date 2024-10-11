//
//  ConsciousnessExamView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 10/10/2024.
//

import SwiftUI
import UIKit

class ConsciousnessExamView: UIView{
    
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
    
}
  
