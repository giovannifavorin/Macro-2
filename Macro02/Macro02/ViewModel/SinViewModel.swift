import UIKit

class SinViewModel: ObservableObject {
    
    weak var view: UIViewController?
    
    @Published var savedSins: [Sin] = []
    @Published var committedSins: [SinsInExamination] = []
    
    private let sinDataManager = DataManager.shared
    
    init() {
        fetchSavedSins()
        fetchCommittedSins()
    }
    
    func isQuestionMarkedAsSin(question: String) -> Bool {
        return committedSins.contains { $0.sins?.contains { ($0 as? Sin)?.sinDescription == question } ?? false }
    }
    
    func markAsSin(commandments: String, commandmentDescription: String, question: String, for exam: ConscienceExam) {
        if let sin = sinDataManager.createSin(commandments: commandments, commandmentDescription: commandmentDescription, sinDescription: question) {
            if let sinsInExamination = sinDataManager.createSinsInExamination(isConfessed: false, recurrence: 1, sins: [sin]) {
                exam.addToSinsInExamination(sinsInExamination)
                // saveContext será chamado internamente
            }
            fetchCommittedSins() // Atualiza a lista de pecados cometidos
        }
    }
    
    func unmarkAsSin(question: String, for exam: ConscienceExam) {
        // Usamos guard para evitar unwraps inseguros
        guard let sin = committedSins.flatMap({ $0.sins?.allObjects as? [Sin] ?? [] }).first(where: { $0.sinDescription == question }) else {
            return // Se não encontrar o pecado, não faz nada
        }
        
        // Remove a entidade SinsInExamination associada ao pecado
        for sinsInExamination in committedSins {
            if let sins = sinsInExamination.sins as? Set<Sin>, sins.contains(sin) {
                exam.removeFromSinsInExamination(sinsInExamination)
                sinDataManager.deleteSin(sin) // A exclusão do pecado chama saveContext internamente
                fetchCommittedSins() // Atualiza a lista de pecados cometidos
                break // Não precisamos continuar a busca após encontrar e remover
            }
        }
    }
    
    func fetchSavedSins() {
        savedSins = sinDataManager.fetchAllSins()
    }
    
    
    /// Busca todos os pecados cometidos associados às confissões do usuário.
    ///
    /// Esta função recupera todas as confissões do `sinDataManager`, em seguida, mapeia cada confissão
    /// para obter todos os exames de consciência associados. Para cada exame, ela busca os pecados
    /// sendo examinados e filtra para incluir apenas aqueles que foram marcados como confessados.
    ///
    /// O resultado é um array achatado de `SinsInExamination` que foram confessados em todas as
    /// confissões e seus respectivos exames. Esse array é armazenado na propriedade `committedSins`.
    ///
    func fetchCommittedSins() {
        // Busca todas as confissões
        let confessions = sinDataManager.fetchAllConfessions()
        
        // Mapeia as confissões para obter todos os SinsInExamination
        committedSins = confessions.flatMap { confession in
            // Para cada confissão, busca os exames de consciência
            let exams = sinDataManager.fetchAllExams(for: confession)
            
            // Para cada exame, busca os pecados em exame e filtra os que foram confessados
            return exams.flatMap { exam in
                return sinDataManager.fetchAllSinsInExaminations(for: exam).filter { $0.isConfessed }
            }
        }
        
        /*
         Retorno:
         A função retorna um array de SinsInExamination que contém todos os pecados que foram
         confessados em cada exame de consciência, filtrando apenas aqueles com isConfessed = true.
         Por exemplo, se houver duas confissões, e cada uma tiver exames com pecados
         confessados, o retorno será um array contendo os pecados confessados dessas confissões.
         
         Exemplo de retorno:
         [
         SinsInExamination(id: 1, isConfessed: true, sins: [Sin(id: 201, sinDescription: "Pecado A")]), // Confissão 1, Exame 1
         SinsInExamination(id: 2, isConfessed: true, sins: [Sin(id: 203, sinDescription: "Pecado C")]), // Confissão 1, Exame 2
         SinsInExamination(id: 3, isConfessed: true, sins: [Sin(id: 204, sinDescription: "Pecado D"), Sin(id: 205, sinDescription: "Pecado E")]) // Confissão 2, Exame 1
         ]
         */
    }
}
