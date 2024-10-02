//
//  SacramentOfConfessionViewController.swift
//  Macro02
//
//  Created by Giovanni Favorin de Melo on 02/10/24.
//

import UIKit

class SacramentOfConfessionViewController: UIViewController {

    var titleLabel: UILabel!
    var textView: UITextView!

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .darkGray
        setupUI()
        setupConstraints()
    }

    func setupUI() {
        // Configurando o título
        titleLabel = UILabel()
        titleLabel.text = "Sacramento da Confissão"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.textColor = .black
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Configurando o texto descritivo
        textView = UITextView()
        textView.text = """
        No momento do sacramento da reconciliação – ou confissão –, somos convidados a reconhecer nossos pecados e rezar o ato de contrição diante do Senhor.

        Às vezes temos dificuldades de reconhecer nossos pecados. Rezar antes de realizar a confissão pode nos ajudar.
        """
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textColor = .black
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.backgroundColor = .clear
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            // Constraints do título
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            // Constraints do texto descritivo
            textView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
    }
}
