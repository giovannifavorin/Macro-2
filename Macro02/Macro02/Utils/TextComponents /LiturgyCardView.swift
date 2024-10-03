//
//  LiturgyCardView.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 03/10/24.
//

import UIKit

/// Card que exibe informações da liturgia na `LiturgyView`.
///
/// O card contém as seguintes informações:
/// - Semana atual da liturgia exibida no `weekNumberLabel`.
/// - Dia da semana atual em formato de texto no `dayNameLabel`.
/// - Dia da liturgia em formato de número no `dayNumberLabel`.
/// - Mês em formato de texto no `monthNameLabel`.
/// - Ano no formato de número em `yearNumberLabel`.
///
/// Este componente é utilizado no protótipo de média na View de liturgia para exibir dados relacionados à data.

class LiturgyCardView: UIView {
    
    private var dataLiturgia = String()
        
    private let weekNumberLabel = TextComponent()
    private let dayNameLabel = TextComponent()
    
    private let dayNumberLabel = TextComponent()
    private let monthNameLabel = TextComponent()
    private let yearNumberLabel = TextComponent()
    private let colorLiturgy = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
        
        addSubview(weekNumberLabel)
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        addSubview(monthNameLabel)
        addSubview(yearNumberLabel)
        
        setConstraints()
    }
    
    func update(with liturgia: Liturgia) {
        weekNumberLabel.text = liturgia.data ?? "no data week label"
        dayNameLabel.text = liturgia.dia
        dayNumberLabel.text = liturgia.data ?? "no dayNumberLabel"
        monthNameLabel.text = liturgia.data ?? "no monthNameLabel"
        yearNumberLabel.text = "\(liturgia.data) / \(liturgia.data)"
        self.dataLiturgia = liturgia.data ?? "no data"
        print(self.dataLiturgia)
    }
}

extension LiturgyCardView {
    private func setConstraints() {
        weekNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        dayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        dayNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        monthNameLabel.translatesAutoresizingMaskIntoConstraints = false
        yearNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weekNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            weekNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            dayNameLabel.topAnchor.constraint(equalTo: weekNumberLabel.bottomAnchor, constant: 8),
            dayNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            dayNumberLabel.topAnchor.constraint(equalTo: dayNameLabel.bottomAnchor, constant: 8),
            dayNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            monthNameLabel.topAnchor.constraint(equalTo: dayNumberLabel.bottomAnchor, constant: 8),
            monthNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            yearNumberLabel.topAnchor.constraint(equalTo: monthNameLabel.bottomAnchor, constant: 8),
            yearNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            yearNumberLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }
}
