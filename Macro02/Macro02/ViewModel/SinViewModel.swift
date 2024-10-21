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
        fetchSavedSins()
    }
    
    // Carrega os mandamentos e as perguntas relacionadas
    func loadCommandments(_ int: Int) -> [Commandment] {
        
        switch int {
        case 1:
            return [Commandment(title: "Primeiro Mandamento", description: "Amar a Deus sobre todas as coisas", sins: [
                "Neguei ou abandonei a minha fé.",
                "Tenho a preocupação de conhecê-la melhor.",
                "Recusei-me a defender a minha fé ou fiquei envergonhado dela.",
                "Existe algum aspecto da minha fé que eu ainda não aceito.",
                "Pratiquei o espiritismo ou coloquei a minha confiança em adivinhos ou horóscopos.",
                "Manifestei falta de respeito pelas pessoas, lugares ou coisas santas.",
                "Descuidei da minha responsabilidade de aproximar os outros de Deus, com o meu exemplo e a minha palavra.",
            ]),
                    
                    Commandment(title: "Segundo Mandamento", description: "Não tomar o nome de Deus em vão", sins: [
                        "Disse o nome de Deus em vão."
                    ]),
                    
                    Commandment(title: "Terceiro Mandamento", description: "Guardar domingos e festas de guarda", sins: [
                        "Faltei voluntariamente à Missa nos domingos ou dias de preceito.",
                        "Recebi a Comunhão sem agradecimento ou sem a devida reverência."
                    ]),
                    
            ]
            
        case 2:
            return [
                Commandment(title: "Quarto Mandamento", description: "Honrar pai e mãe", sins: [
                "Não honrei os meus pais ou figuras de autoridade."
                ]),
                    
                    Commandment(title: "Quinto Mandamento", description: "Não matar", sins: [
                        "Fui violento nas palavras ou ações com outros.",
                        "Tive ódio ou juízos críticos, em pensamentos ou ações.",
                        "Olhei os outros com desprezo.",
                        "Colaborei ou encorajei alguém a fazer um aborto, destruir embriões humanos, praticar a eutanásia ou outro meio de acabar com a vida.",
                        "Abusei de bebidas alcoólicas.",
                        "Usei drogas."
                    ]),
                    
                    Commandment(title: "Sexto Mandamento", description: "Não pecar contra a castidade", sins: [
                        "Assisti vídeos ou acessei sites pornográficos.",
                        "Cometi atos impuros, sozinho ou com outras pessoas.",
                        "Estou morando com alguém como se fosse casado, sem que o seja.",
                        "Se sou casado, não procuro amar o meu cônjuge mais do que a qualquer outra pessoa.",
                        "Não coloco meu casamento em primeiro lugar.",
                        "Não tenho uma atitude aberta para novos filhos."
                    ]),
                    
                    
                    Commandment(title: "Sétimo Mandamento", description: "Não furtar", sins: [
                        "Roubei ou enganei alguém no trabalho.",
                        "Gastei dinheiro com o meu conforto e luxo pessoal, esquecendo minhas responsabilidades para com os outros e para com a Igreja."
                    ]),
                    
            ]
            
        case 3:
            return [
                
                Commandment(title: "Oitavo Mandamento", description: "Não levantar falso testemunho", sins: [
                    "Falei mal dos outros, transformando o assunto em fofoca.",
                    "Disse mentiras.",
                    "Não fui honesto ou diligente no meu trabalho."
                ]),
                
                Commandment(title: "Nono Mandamento", description: "Não desejar a mulher do próximo", sins: [
                        "Desejei ou tive pensamentos impuros com pessoas que não são meu cônjuge (implícito nas questões de pureza e castidade)."
                ]),
                
                Commandment(title: "Décimo Mandamento", description: "Não cobiçar as coisas alheias", sins: [
                "Fui invejoso.",
                "Fui orgulhoso ou egoísta em meus pensamentos e ações.",
                "Cedi à preguiça.",
                "Preferi a comodidade ao invés de servir aos demais.",
                "Trabalhei de forma desordenada, ocupando tempo e energias que deveria dedicar à minha família e amigos."
                ])
                   
            ]
            
        default:
            return []
        }
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
