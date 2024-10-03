//
//  LiturgyCardView.swift
//  Macro02
//
//  Created by Thiago Pereira de Menezes on 03/10/24.
//

import UIKit

class LiturgyCardView: UIView {
    
    private let weekLabel = UILabel()
    private let dayNameLabel = UILabel()
    private let dayNumberLabel = UILabel()
    private let monthYearLabel = UILabel()
    
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
