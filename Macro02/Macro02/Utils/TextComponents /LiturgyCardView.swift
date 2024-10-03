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
/// - Semana atual da liturgia exibida no `weekLabel`.
/// - Dia da semana atual em formato de texto no `dayNameLabel`.
/// - Dia do mês em formato numérico no `dayNumberLabel`.
/// - Mês abreviado e ano completo no `monthYearLabel`.
///
/// Este componente é utilizado no protótipo de média na View de liturgia para exibir dados relacionados à data.

class LiturgyCardView: UIView {
    
    private let weekLabel = TextComponent()
    private let dayNameLabel = TextComponent()
    private let dayNumberLabel = TextComponent()
    private let monthYearLabel = TextComponent()
    
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
        
        addSubview(weekLabel)
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        addSubview(monthYearLabel)
    }
    
    func update(with liturgia: Liturgia) {
        weekLabel.text = liturgia.data ?? "no data week label"
        dayNameLabel.text = liturgia.dia
        dayNumberLabel.text = liturgia.data ?? "no dayNumberLabel"
        monthYearLabel.text = "\(liturgia.data) / \(liturgia.data)"
    }
}
