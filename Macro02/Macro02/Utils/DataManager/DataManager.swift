import CoreData

class DataManager {
    
    // Singleton
    static let shared = DataManager()
    
    // Evitar a criação de múltiplas instâncias
    private init() {
        preloadDataIfNeeded()
    }
    
    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private func preloadDataIfNeeded() {
        if fetchAllSins().isEmpty {
            insertMockSins()
        }
    }
    
    private func insertMockSins() {
        let commandments = [
            ("Décimo Mandamento", "Não cobiçar as coisas alheias", [
                "Fui invejoso?",
                "Fui orgulhoso ou egoísta em meus pensamentos e ações?",
                "Cedi à preguiça?",
                "Preferi a comodidade ao invés de servir aos demais?",
                "Trabalhei de forma desordenada, ocupando tempo e energias que deveria dedicar à minha família e amigos?"
            ]),
            ("Nono Mandamento", "Não desejar a mulher do próximo", [
                "Desejei ou tive pensamentos impuros com pessoas que não são meu cônjuge (implícito nas questões de pureza e castidade)?"
            ]),
            ("Oitavo Mandamento", "Não levantar falso testemunho", [
                "Falei mal dos outros, transformando o assunto em fofoca?",
                "Disse mentiras?",
                "Não fui honesto ou diligente no meu trabalho?"
            ]),
            ("Sétimo Mandamento", "Não furtar", [
                "Roubei ou enganei alguém no trabalho?",
                "Gastei dinheiro com o meu conforto e luxo pessoal, esquecendo minhas responsabilidades para com os outros e para com a Igreja?"
            ]),
            ("Sexto Mandamento", "Não pecar contra a castidade", [
                "Assisti vídeos ou acessei sites pornográficos?",
                "Cometi atos impuros, sozinho ou com outras pessoas?",
                "Estou morando com alguém como se fosse casado, sem que o seja?",
                "Se sou casado, não procuro amar o meu cônjuge mais do que a qualquer outra pessoa?",
                "Não coloco meu casamento em primeiro lugar?",
                "Não tenho uma atitude aberta para novos filhos?"
            ]),
            ("Quinto Mandamento", "Não matar", [
                "Fui violento nas palavras ou ações com outros?",
                "Tive ódio ou juízos críticos, em pensamentos ou ações?",
                "Olhei os outros com desprezo?",
                "Colaborei ou encorajei alguém a fazer um aborto, destruir embriões humanos, praticar a eutanásia ou outro meio de acabar com a vida?",
                "Abusei de bebidas alcoólicas?",
                "Usei drogas?"
            ]),
            ("Quarto Mandamento", "Honrar pai e mãe", [
                "Não honrei os meus pais ou figuras de autoridade?"
            ]),
            ("Terceiro Mandamento", "Guardar domingos e festas de guarda", [
                "Faltei voluntariamente à Missa nos domingos ou dias de preceito?",
                "Recebi a Comunhão sem agradecimento ou sem a devida reverência?"
            ]),
            ("Segundo Mandamento", "Não tomar o nome de Deus em vão", [
                "Disse o nome de Deus em vão?"
            ]),
            ("Primeiro Mandamento", "Amar a Deus sobre todas as coisas", [
                "Neguei ou abandonei a minha fé?",
                "Tenho a preocupação de conhecê-la melhor?",
                "Recusei-me a defender a minha fé ou fiquei envergonhado dela?",
                "Existe algum aspecto da minha fé que eu ainda não aceito?",
                "Pratiquei o espiritismo ou coloquei a minha confiança em adivinhos ou horóscopos?",
                "Manifestei falta de respeito pelas pessoas, lugares ou coisas santas?",
                "Descuidei da minha responsabilidade de aproximar os outros de Deus, com o meu exemplo e a minha palavra?"
            ])
        ]
        
        for (title, description, questions) in commandments {
            for question in questions {
                let sin = Sin(context: context)
                sin.commandments = title
                sin.commandmentDescription = description
                sin.sinDescription = question
            }
        }
        
        saveContext()
    }
    
    // Save context method
    private func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - CREATE
    public func createConfession(date: Date, penance: String, exams: [ConscienceExam]) -> Confession? {
        let newConfession = Confession(context: context)
        newConfession.confessionDate = date
        newConfession.penance = penance
        newConfession.conscienceExams = NSSet(array: exams)
        
        saveContext()
        return newConfession
    }
    
    public func createConscienceExam(date: Date, sinsInExamination: [SinsInExamination]) -> ConscienceExam? {
        let newExam = ConscienceExam(context: context)
        newExam.examDate = date
        newExam.sinsInExamination = NSSet(array: sinsInExamination)
        
        saveContext()
        return newExam
    }
    
    public func createSinsInExamination(isConfessed: Bool, recurrence: Int16, sins: [Sin]) -> SinsInExamination? {
        let newSinsInExam = SinsInExamination(context: context)
        newSinsInExam.isConfessed = isConfessed
        newSinsInExam.recurrence = recurrence
        newSinsInExam.sins = NSSet(array: sins)
        
        saveContext()
        return newSinsInExam
    }
    
    public func createSin(commandments: String, commandmentDescription: String, sinDescription: String) -> Sin? {
        let newSin = Sin(context: context)
        newSin.commandments = commandments
        newSin.commandmentDescription = commandmentDescription
        newSin.sinDescription = sinDescription
        
        saveContext()
        return newSin
    }
    
    // MARK: - READ
    public func fetchAllConfessions() -> [Confession] {
        let request: NSFetchRequest<Confession> = Confession.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Erro ao buscar confissões: \(error)")
            return []
        }
    }

    public func fetchAllExams(for confession: Confession) -> [ConscienceExam] {
        return confession.conscienceExams?.allObjects as? [ConscienceExam] ?? []
    }

    public func fetchAllSinsInExaminations(for exam: ConscienceExam) -> [SinsInExamination] {
        return exam.sinsInExamination?.allObjects as? [SinsInExamination] ?? []
    }

    public func fetchAllSins() -> [Sin] {
        let fetchRequest: NSFetchRequest<Sin> = Sin.fetchRequest()
        
        do {
            return try context.fetch(fetchRequest)
        } catch {
            print("Failed to fetch sins: \(error)")
            return []
        }
    }

    public func fetchLatestConfession() -> Confession? {
        let request: NSFetchRequest<Confession> = Confession.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "confessionDate", ascending: false)]
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Erro ao buscar a última confissão: \(error)")
            return nil
        }
    }
    
    // MARK: - UPDATE
    public func updateConfession(_ confession: Confession, date: Date? = nil, penance: String? = nil) {
        if let date = date { confession.confessionDate = date }
        if let penance = penance { confession.penance = penance }
        
        saveContext()
    }
    
    public func updateSin(_ sin: Sin, commandments: String? = nil, commandmentDescription: String? = nil, sinDescription: String? = nil) {
        if let commandments = commandments { sin.commandments = commandments }
        if let commandmentDescription = commandmentDescription { sin.commandmentDescription = commandmentDescription }
        if let sinDescription = sinDescription { sin.sinDescription = sinDescription }
        
        saveContext()
    }
    
    public func addExamToConfession(confession: Confession, exam: ConscienceExam) {
        let exams = confession.mutableSetValue(forKey: "conscienceExams") // Altere o nome do relacionamento conforme necessário
        exams.add(exam)
        exam.confession = confession // Assumindo que você tenha uma propriedade de relacionamento `confession` no exame
        saveContext() // Salva as alterações
    }
    
    // MARK: - DELETE
    public func deleteConfession(_ confession: Confession) {
        context.delete(confession)
        saveContext()
    }
    
    public func deleteSin(_ sin: Sin) {
        context.delete(sin)
        saveContext()
    }
    
    // MARK: - DELETE ALL
    public func deleteAllConfessions() {
        let request: NSFetchRequest<NSFetchRequestResult> = Confession.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
            saveContext()
        } catch {
            print("Erro ao deletar todas as confissões: \(error)")// MARK: - Lapidar o tratamento de erros
        }
    }
}
