import UIKit
import Combine

class SinViewModel: ObservableObject {
    
    @Published var savedSins: [Sin] = []
    @Published var committedSins: [SinsInExamination] = []
    
    private var pendingSinsInExamination: [SinsInExamination] = [] // Pecados temporários que serão salvos no final do exame
    private let sinDataManager = DataManager.shared
    
    init() {
        fetchAllSins()
    }
    
    // Busca todos os pecados salvos no Core Data
    func fetchAllSins() {
        // Supondo que você tenha uma instância do DataManager
        savedSins = DataManager.shared.fetchAllSins()
        print("Sins fetched: \(savedSins)")
    }
    
    // Verifica se uma questão está marcada como pecado
    func isSinMarked(_ sin: Sin) -> Bool {
        return pendingSinsInExamination.contains { $0.sins?.contains(sin) ?? false }
    }
    
    // Marca uma questão como pecado
    func markSin(_ sin: Sin) {
        if let sinsInExamination = sinDataManager.createSinsInExamination(isConfessed: false, recurrence: 1, sins: [sin]) {
            pendingSinsInExamination.append(sinsInExamination)
        }
    }
    
    // Desmarca uma questão como pecado
    func unmarkSin(_ sin: Sin) {
        if let index = pendingSinsInExamination.firstIndex(where: { $0.sins?.contains(sin) ?? false }) {
            pendingSinsInExamination.remove(at: index)
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
                sinDataManager.createConfession(date: Date(), penance: "", exams: [exam])
            }
            
            fetchCommittedSins()
        }
    }
    
    // Busca os pecados já confessados
    func fetchCommittedSins() {
        let confessions = sinDataManager.fetchAllConfessions()
        committedSins = confessions.flatMap { confession in
            sinDataManager.fetchAllExams(for: confession).flatMap { exam in
                sinDataManager.fetchAllSinsInExaminations(for: exam).filter { $0.isConfessed }
            }
        }
    }
    
    // Busca a última confissão
    func fetchLatestConfession() -> Confession? {
        return sinDataManager.fetchLatestConfession()
    }
    
    // Adiciona um novo pecado
    func addSin(with sinDescription: String) {
        // Exemplo de valores para os mandamentos e descrição, você pode modificar isso conforme necessário
        let commandments = "Mandamento relacionado ao pecado" // Aqui você pode determinar qual mandamento é apropriado
        let commandmentDescription = "Descrição do mandamento" // Descrição que deve ser correspondente ao mandamento
        
        // Cria um novo pecado usando o DataManager
        if let newSin = sinDataManager.createSin(commandments: commandments, commandmentDescription: commandmentDescription, sinDescription: sinDescription) {
            // Adiciona o novo pecado ao array de pecados salvos
            savedSins.append(newSin)
            print("Novo pecado adicionado: \(newSin.sinDescription ?? "")")
        } else {
            print("Falha ao adicionar novo pecado.")
        }
    }

    
    // Retorna todos os pecados marcados
    func getMarkedSins() -> [SinsInExamination] {
        return pendingSinsInExamination
    }
}
