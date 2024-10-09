import UIKit
import CoreData

class DataManager {
    
    // Singleton
    static let shared = DataManager()
    
    // Evitar a criação de múltiplas instâncias
    private init() {}// MARK: - Validar se já foi preenchida a memoria base

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
    
    public func createSin(commandments: String, sinDescription: String) -> Sin? {
        let newSin = Sin(context: context)
        newSin.commandments = commandments
        newSin.sinDescription = sinDescription
        
        saveContext()
        return newSin
    }
    
    // MARK: - READ
    public func fetchAllConfessions() -> [Confession]? {
        let request: NSFetchRequest<Confession> = Confession.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            print("Erro ao buscar confissões: \(error)")
            return nil
        }
    }
    
    public func fetchAllExams(for confession: Confession) -> [ConscienceExam]? {
        return confession.conscienceExams?.allObjects as? [ConscienceExam]
    }
    
    public func fetchAllSinsInExaminations(for exam: ConscienceExam) -> [SinsInExamination]? {
        return exam.sinsInExamination?.allObjects as? [SinsInExamination]
    }
    
    public func fetchAllSins(for sinsInExam: SinsInExamination) -> [Sin]? {
        return sinsInExam.sins?.allObjects as? [Sin]
    }
    
    // MARK: - UPDATE
    public func updateConfession(_ confession: Confession, date: Date? = nil, penance: String? = nil) {
        if let date = date { confession.confessionDate = date }
        if let penance = penance { confession.penance = penance }
        
        saveContext()
    }
    
    public func updateSin(_ sin: Sin, commandments: String? = nil, sinDescription: String? = nil) {
        if let commandments = commandments { sin.commandments = commandments }
        if let sinDescription = sinDescription { sin.sinDescription = sinDescription }
        
        saveContext()
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
