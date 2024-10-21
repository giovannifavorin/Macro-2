//
//  BibleView.swift
//  Macro02
//
//  Created by Gabriel Ribeiro Noronha on 21/10/2024.
//

import UIKit

class BibleView: UIView {
    
    let titleLabel: TextComponent = {
        let label = TextComponent("BIBLE VIEW")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.setCustomFont(.titulo1) // Using English naming
        return label
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        addSubview(tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
            //            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            //            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}

