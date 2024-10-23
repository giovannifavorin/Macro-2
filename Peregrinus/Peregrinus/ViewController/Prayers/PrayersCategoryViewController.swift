//
//  PrayersViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 20/09/24.
//

//import UIKit
import SwiftUI
import UIKit

class PrayersCategoryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var viewModel: PrayersViewModel?
    var coordinator: PrayersCoordinator?
    
    var collectionView: UICollectionView!
    var prayerCategories: [PrayerCategory]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewModel = viewModel {
            self.prayerCategories = viewModel.prayerCategories
        }

        self.view.backgroundColor = .white
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16 // Espaçamento entre os itens
        layout.minimumLineSpacing = 16 // Espaçamento entre as linhas
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16) // Padding nas bordas

        collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PrayerCategoryCell.self, forCellWithReuseIdentifier: "PrayerCategoryCell")
        collectionView.backgroundColor = .white
        
        self.view.addSubview(collectionView)
    }
    
    // Número de itens na seção
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return prayerCategories.count
    }
    
    // Configuração da célula
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrayerCategoryCell", for: indexPath) as! PrayerCategoryCell
        let category = prayerCategories[indexPath.row]
        
        // Configure a célula
        cell.configure(with: category)
        
        return cell
    }
    
    // Tamanho da célula (quadrado)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let availableWidth = collectionView.frame.width - padding * 3 // Considerando o padding nas bordas
        let itemWidth = availableWidth / 2
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    // Método para detectar a seleção do item
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCategory = prayerCategories[indexPath.row]
        
        // Navegação para a view de orações usando o coordinator
        coordinator?.navigateToDetail(category: selectedCategory)
    }
}


class PrayerCategoryCell: UICollectionViewCell {
    
    // Elementos da célula
    let categoryImageView = UIImageView()
    let categoryLabel1 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        // Configuração da imagem
        categoryImageView.contentMode = .scaleAspectFit
        categoryImageView.clipsToBounds = true
        categoryImageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Configuração do label da categoria
        categoryLabel1.textAlignment = .left
        categoryLabel1.textColor = .black
        categoryLabel1.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        categoryLabel1.translatesAutoresizingMaskIntoConstraints = false
        
        // Adicione a imagem e o label diretamente ao contentView
        contentView.addSubview(categoryImageView)
        contentView.addSubview(categoryLabel1)
        
        // Configuração visual da célula
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            categoryImageView.heightAnchor.constraint(equalToConstant: 50), // Altura da imagem
            categoryImageView.widthAnchor.constraint(equalToConstant: 50)  // Largura da imagem
        ])
        
        // Constraints para posicionar o label no canto inferior esquerdo
        NSLayoutConstraint.activate([
            categoryLabel1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            categoryLabel1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            categoryLabel1.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -8) // Caso o texto seja maior
        ])
    }
    
    // Função para configurar a célula com os dados da categoria
    func configure(with category: PrayerCategory) {
        categoryImageView.image = category.image
        categoryLabel1.text = category.name
    }
}

