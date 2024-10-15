import UIKit

protocol SinViewModelDelegate: AnyObject {
    func didUpdateSavedSins(_ savedSins: [Sin])
    func didUpdateCommittedSins(_ committedSins: [SinsInExamination])
    func didFailToAddSin(with message: String)
}

class SinViewModel {
    
    private var _savedSins: [Sin] = []
    private var _committedSins: [SinsInExamination] = []
    
    var savedSins: [Sin] {
        return _savedSins
    }
    
    var committedSins: [SinsInExamination] {
        return _committedSins
    }
    
    private var pendingSinsInExamination: [SinsInExamination] = [] // Pecados temporários que serão salvos no final do exame
    private let sinDataManager = DataManager.shared
    weak var delegate: SinViewModelDelegate?
    
    init() {
        fetchAllSins()
    }
    
    // Busca todos os pecados salvos no Core Data
    func fetchAllSins() {
        _savedSins = DataManager.shared.fetchAllSins()
        delegate?.didUpdateSavedSins(savedSins) // Notifica a delegate sobre a atualização
    }
    
    // Verifica se uma questão está marcada como pecado
    func isSinMarked(_ sin: Sin) -> Bool {
        return pendingSinsInExamination.contains { $0.sins?.contains(sin) ?? false }
    }
    
    // Marca uma questão como pecado
    func markSin(_ sin: Sin) {
        if let sinsInExamination = sinDataManager.createSinsInExamination(isConfessed: false, recurrence: 1, sins: [sin]) {
            pendingSinsInExamination.append(sinsInExamination)
            fetchCommittedSins() // Atualiza os pecados confessados
            delegate?.didUpdateCommittedSins(committedSins) // Notifica a delegate
        }
    }
    
    // Desmarca uma questão como pecado
    func unmarkSin(_ sin: Sin) {
        if let index = pendingSinsInExamination.firstIndex(where: { $0.sins?.contains(sin) ?? false }) {
            pendingSinsInExamination.remove(at: index)
            fetchCommittedSins() // Atualiza os pecados confessados
            delegate?.didUpdateCommittedSins(committedSins) // Notifica a delegate
        }
    }
    
    // Salva o exame na confissão mais recente ou cria uma nova
    func saveExamToConfession() {
        // Cria um novo exame
        if let exam = sinDataManager.createConscienceExam(date: Date(), sinsInExamination: pendingSinsInExamination) {
            pendingSinsInExamination.removeAll() // Limpa o array temporário após salvar
            
            // Busca a última confissão
            if let confession = fetchLatestConfession() {
                // Adiciona o exame à confissão no DataManager
                sinDataManager.addExamToConfession(confession: confession, exam: exam)
            } else {
                // Cria uma nova confissão e adiciona o exame a ela
                guard sinDataManager.createConfession(date: Date(), penance: "", exams: [exam]) != nil else {
                    print("Falha ao criar nova confissão.")
                    return
                }
            }
            
            fetchCommittedSins()
        }
    }
    
    // Busca os pecados já confessados
    func fetchCommittedSins() {
        let confessions = sinDataManager.fetchAllConfessions()
        _committedSins = confessions.flatMap { confession in
            sinDataManager.fetchAllExams(for: confession).flatMap { exam in
                sinDataManager.fetchAllSinsInExaminations(for: exam).filter { $0.isConfessed }
            }
        }
        delegate?.didUpdateCommittedSins(committedSins) // Notifica a delegate sobre a atualização
    }
    
    // Busca a última confissão
    func fetchLatestConfession() -> Confession? {
        return sinDataManager.fetchLatestConfession()
    }
    
    func countUniqueCommandments() -> Int {
        var uniqueCommandments = Set<String>() // Usamos um Set para garantir que os mandamentos sejam únicos
        
        for sin in _savedSins {
            if let commandments = sin.commandments { // Verifique se o atributo commandments não é nulo
                uniqueCommandments.insert(commandments) // Adiciona o mandamento ao Set
            }
        }
        
        return uniqueCommandments.count // Retorna a contagem de mandamentos únicos
    }
    
    // Adiciona um novo pecado
    func addSin(with sinDescription: String) {
        // Verifica se o pecado já existe
        guard !_savedSins.contains(where: { $0.sinDescription == sinDescription }) else {
            delegate?.didFailToAddSin(with: "Pecado já existe.")
            return
        }
        
        // Exemplo de valores para os mandamentos e descrição
        let commandments = "Mandamento relacionado ao pecado" // Aqui você pode determinar qual mandamento é apropriado
        let commandmentDescription = "Descrição do mandamento" // Descrição que deve ser correspondente ao mandamento
        
        // Cria um novo pecado usando o DataManager
        if let newSin = sinDataManager.createSin(commandments: commandments, commandmentDescription: commandmentDescription, sinDescription: sinDescription) {
            // Adiciona o novo pecado ao array de pecados salvos
            _savedSins.append(newSin)
            print("Novo pecado adicionado: \(newSin.sinDescription ?? "")")
            delegate?.didUpdateSavedSins(savedSins) // Notifica a delegate sobre a atualização
        } else {
            delegate?.didFailToAddSin(with: "Falha ao adicionar novo pecado.")
        }
    }
    
    // Retorna todos os pecados marcados
    func getMarkedSins() -> [SinsInExamination] {
        return pendingSinsInExamination
    }
}
