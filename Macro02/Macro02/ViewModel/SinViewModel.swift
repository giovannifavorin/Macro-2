import UIKit
import Combine

class SinViewModel: ObservableObject {
    
    weak var view: UIViewController?
    
    @Published var savedSins: [Sin] = []
    @Published var committedSins: [SinsInExamination] = []
    
    private var pendingSinsInExamination: [SinsInExamination] = [] // Pecados temporários que serão salvos no final do exame
    private let sinDataManager = DataManager.shared
    
    init() {
        fetchSavedSins()
    }
    
    // Verifica se uma questão está marcada como pecado
    func isQuestionMarkedAsSin(question: String) -> Bool {
        return committedSins.contains { $0.sins?.contains { ($0 as? Sin)?.sinDescription == question } ?? false }
    }
    
    // Marca uma questão como pecado
    func markAsSin(commandments: String, commandmentDescription: String, question: String) {
        if let sin = savedSins.first(where: { $0.sinDescription == question }) {
            if let sinsInExamination = sinDataManager.createSinsInExamination(isConfessed: false, recurrence: 1, sins: [sin]) {
                pendingSinsInExamination.append(sinsInExamination)
            }
        } else {
            print("Erro: Pecado não encontrado na lista de pecados salvos.")
        }
    }
    
    // Desmarca uma questão como pecado
    func unmarkAsSin(question: String) {
        if let index = pendingSinsInExamination.firstIndex(where: { $0.sins?.contains { ($0 as? Sin)?.sinDescription == question } ?? false }) {
            pendingSinsInExamination.remove(at: index)
        } else {
            print("Erro: Pecado não encontrado na lista de pecados em exame.")
        }
    }
    
    // Busca todos os pecados salvos no Core Data
    func fetchSavedSins() {
        savedSins = sinDataManager.fetchAllSins()
    }
    
    // Salva o exame na confissão mais recente ou cria uma nova
    func saveExamToConfession() {
        // Cria um novo exame
        if let exam = sinDataManager.createConscienceExam(date: Date(), sinsInExamination: pendingSinsInExamination) {
            pendingSinsInExamination.removeAll() // Limpa o array temporário após salvar
            
            // Busca a última confissão
            if let confession = sinDataManager.fetchLatestConfession() {
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
}
