//
//  DailyLiturgyViewController.swift
//  Macro02
//
//  Created by Victor Dantas on 18/09/24.
//

import UIKit

class DailyLiturgyViewController: UIViewController {

    // MARK: - Properties
    var viewModel: DailyLiturgyViewModel
    var apiManager = LiturgiaDiariaAPI()  // Instância da API
    var activityIndicator: UIActivityIndicatorView!
    
    // Dados da liturgia
    var liturgia: Liturgia?

    // MARK: - UI Elements
    private let tableView = UITableView()

    // MARK: - Initializer
    init(viewModel: DailyLiturgyViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        fetchLiturgiaDiaria()
    }

    // MARK: - Setup Methods
    private func setupView() {
        view.backgroundColor = .white

        // Configura a tabela
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        // Adiciona o indicador de carregamento (spinner)
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        // Define as constraints
        setupConstraints()
    }

    // MARK: - API Methods
    private func fetchLiturgiaDiaria() {
        apiManager.fetchLiturgia { [weak self] result in
            DispatchQueue.main.async {
                self?.activityIndicator.stopAnimating()  // Para o spinner quando os dados chegam
                
                switch result {
                case .success(let liturgia):
                    self?.liturgia = liturgia
                    self?.tableView.reloadData()  // Atualiza a tabela com os dados da liturgia
                case .failure(let error):
                    self?.showError(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Error Handling
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    // MARK: - Layout Methods
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension DailyLiturgyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8 // Número total de itens a serem exibidos (você pode ajustar isso com base na sua estrutura de dados)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0 // Permite múltiplas linhas
        
        // Configure o texto com base no índice
        if let liturgia = liturgia {
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Liturgia de Hoje"
            case 1:
                cell.textLabel?.text = "Data: \(liturgia.data ?? "Data não disponível")"
            case 2:
                cell.textLabel?.text = "Cor: \(liturgia.cor ?? "Não disponível")"
            case 3:
                cell.textLabel?.text = "Dia: \(liturgia.dia ?? "Não disponível")"
            case 4:
                cell.textLabel?.text = "Oferendas: \(liturgia.oferendas ?? "Não disponível")"
            case 5:
                cell.textLabel?.text = "Comunhão: \(liturgia.comunhao ?? "Não disponível")"
            case 6:
                cell.textLabel?.text = "Primeira Leitura: \(liturgia.primeiraLeitura?.texto ?? "Não disponível")"
            case 7:
                cell.textLabel?.text = "Evangelho: \(liturgia.evangelho?.texto ?? "Não disponível")"
            default:
                break
            }
        }
        
        return cell
    }
}
