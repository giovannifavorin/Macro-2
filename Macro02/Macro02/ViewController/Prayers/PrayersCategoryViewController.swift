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
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
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
        let availableWidth = collectionView.frame.width - padding * 3
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
    let stackView = UIStackView()
    
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
        
        // Configuração dos títulos
        categoryLabel1.textAlignment = .center
        
        // Configuração do stack view para as colunas
        let labelStack = UIStackView(arrangedSubviews: [categoryLabel1])
        labelStack.axis = .horizontal
        labelStack.distribution = .fillEqually
        labelStack.spacing = 8
        
        // Organize a imagem e o stack de labels verticalmente
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.addArrangedSubview(categoryImageView)
        stackView.addArrangedSubview(labelStack)
        
        // Adicione o stack view à célula
        contentView.addSubview(stackView)
        
        // Configuração visual da célula
        contentView.backgroundColor = .lightGray
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true
    }
    
    private func setupConstraints() {
        // Constraints para o stackView dentro da célula
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            categoryImageView.heightAnchor.constraint(equalToConstant: 50), // Ajuste a altura da imagem
            categoryImageView.widthAnchor.constraint(equalToConstant: 50)  // Ajuste a largura da imagem
        ])
    }
    
    // Função para configurar a célula com os dados da categoria
    func configure(with category: PrayerCategory) {
        categoryImageView.image = category.image
        categoryLabel1.text = category.name
        
    }
}
