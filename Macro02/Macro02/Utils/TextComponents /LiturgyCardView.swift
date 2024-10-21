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
    private var colorLiturgy = UIColor()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .systemBackground // Adapta o background para modo claro e escuro
        layer.cornerRadius = 8
        layer.borderWidth = 1

        // Define a cor da borda para ser dinâmica
        layer.borderColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
        }.cgColor

        self.weekNumberLabel.setDynamicFont(size: 14, weight: .bold)
        self.dayNumberLabel.font = UIFont.setCustomFont(.titulo1)
        addSubview(weekNumberLabel)
        addSubview(dayNameLabel)
        addSubview(dayNumberLabel)
        addSubview(monthNameLabel)
        addSubview(yearNumberLabel)

        setConstraints()
    }
    
    func update(with liturgia: Liturgia) {
        
        //NOTE: NÃO SEI PORQUE MAS SE APAGAR ESTAS 6 LINHAS DE CÓDIGO O COMPONENTE PARA DE FUNCIONAR, NÃO APAGUE
        weekNumberLabel.text = liturgia.data ?? "no data week label"
        dayNameLabel.text = liturgia.dia
        dayNumberLabel.text = liturgia.data ?? "no dayNumberLabel"
        monthNameLabel.text = liturgia.data ?? "no monthNameLabel"
        yearNumberLabel.text = "\(liturgia.data ?? "liturgy data not found") / \(liturgia.data ?? "Litugy data not found")"
        self.dataLiturgia = liturgia.data ?? "no data"
        
        // Atualiza com base na dataLiturgia
        self.weekNumberLabel.text = "23º Semana do Tempo Comum"
        self.dayNameLabel.text = getWeekdayName(from: dataLiturgia, length: 3)
        self.dayNumberLabel.text = getDayNumber(from: dataLiturgia)
        self.monthNameLabel.text = getMonthName(from: dataLiturgia)
        self.yearNumberLabel.text = getYearNumber(from: dataLiturgia)
        self.colorLiturgy = colorFromString(liturgia.cor ?? "😳")
        self.weekNumberLabel.textColor = self.colorLiturgy

    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        // Verifica se o estilo de interface mudou
        if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            // Atualiza a cor da borda conforme o modo de interface (claro ou escuro)
            layer.borderColor = UIColor { traitCollection in
                return traitCollection.userInterfaceStyle == .dark ? UIColor.white : UIColor.black
            }.cgColor
        }
    }
    
    /// Retorna o dia da semana em String, permite escolher a quantidade de caracteres do dia da semana
    private func getWeekdayName(from dateString: String, length: Int) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "EEEE" // Formato completo do dia da semana
        let fullWeekday = dateFormatter.string(from: date)
        
        return String(fullWeekday.prefix(length)) // Retorna o nome com a quantidade de caracteres desejada
    }
    
    /// Retorna o nome do mês, recebe data como parametro
    private func getMonthName(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "MMM" // Abreviação de 3 caracteres do mês
        return dateFormatter.string(from: date)
    }
    
    /// Função que retorna o número do mês, recebe uma data como parâmetro
    private func getMonthNumber(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "MM" // Número do mês
        return dateFormatter.string(from: date)
    }
    
    /// Recebe uma data no formato dd-MM-yyyy e retorna apenas o ano "yyyy"
    private func getYearNumber(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "yyyy" // Número do ano completo
        return dateFormatter.string(from: date)
    }
    
    /// Recebe uma data no formato dd-MM-yyyy e retorna apenas o dia "dd"
    private func getDayNumber(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy" // Formato esperado da data
        guard let date = dateFormatter.date(from: dateString) else {
            return "Invalid Date"
        }
        
        dateFormatter.dateFormat = "dd" // Formato para obter apenas o dia
        return dateFormatter.string(from: date)
    }
    
    /// Converte o parametro Liturgia.cor  para uma UIcolor
    private func colorFromString(_ colorName: String) -> UIColor {
        switch colorName.lowercased() {
        case "verde":
            return UIColor.green
        case "branco":
            return UIColor.white
        case "vermelho":
            return UIColor.red
        case "roxo":
            return UIColor.purple
        case "preto":
            return UIColor.black
        case "rosa":
            return UIColor.systemPink
        default:
            return UIColor.white
        }
    }
    
}

extension LiturgyCardView {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            // weekNumberLabel
            weekNumberLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            weekNumberLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            // dayNameLabel
            dayNameLabel.topAnchor.constraint(equalTo: weekNumberLabel.bottomAnchor, constant: 8),
            dayNameLabel.leadingAnchor.constraint(equalTo: weekNumberLabel.leadingAnchor),
            
            // monthNameLabel
            monthNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            monthNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            
            // yearNumberLabel
            yearNumberLabel.topAnchor.constraint(equalTo: monthNameLabel.bottomAnchor, constant: 8),
            yearNumberLabel.trailingAnchor.constraint(equalTo: monthNameLabel.trailingAnchor),
            
            // dayNumberLabel
            dayNumberLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            dayNumberLabel.trailingAnchor.constraint(equalTo: monthNameLabel.leadingAnchor, constant: -16),
            
            // Bottom padding for the yearNumberLabel
            yearNumberLabel.bottomAnchor.constraint(lessThanOrEqualTo: self.bottomAnchor, constant: -16)
        ])

    }
}
