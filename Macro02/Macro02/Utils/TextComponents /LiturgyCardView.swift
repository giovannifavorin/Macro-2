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
/// - Dia da liturggia em formado de número `dayNameLabel`
/// - Dia da liturgia em formato de número `yearNumberLabel`
/// - Mês em formato de texto no `monthNameLabel`.
/// - Ano no formato de número em `yearNumberLabel`.
///
/// Este componente é utilizado no protótipo de média na View de liturgia para exibir dados relacionados à data.

class LiturgyCardView: UIView {
        
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
        addSubview(yearNumberLabel)
    }
    
    private func constrains() {
        
    }
    
    func update(with liturgia: Liturgia) {
        weekNumberLabel.text = liturgia.data ?? "no data week label"
        dayNameLabel.text = liturgia.dia
        dayNumberLabel.text = liturgia.data ?? "no dayNumberLabel"
        yearNumberLabel.text = "\(liturgia.data) / \(liturgia.data)"
    }
}
