import UIKit
import CoreData

class SinDataManager {
    
    // Singleton
    static let shared = SinDataManager()
    
    // Evitar a criação de múltiplas instâncias
    private init() {}

    // MARK: - Persistent Container
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel") // Nome do modelo Core Data (.xcdatamodeld)
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    // Save context method
    func saveContext() {
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
    
    // Referência ao contexto do Core Data (Agora acessado diretamente via o singleton)
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - CREATE
    func createSin(isConfessed: Bool, sinDescription: String) -> Sin? {
        let newSin = Sin(context: context)
        newSin.isConfessed = isConfessed
        newSin.sinDescription = sinDescription
        
        do {
            try context.save()
            return newSin
        } catch {
            print("Erro ao salvar novo pecado: \(error)")
            return nil
        }
    }
    
    // MARK: - READ
    func fetchAllSins() -> [Sin]? {
        let request: NSFetchRequest<Sin> = Sin.fetchRequest()
        
        do {
            let sins = try context.fetch(request)
            return sins
        } catch {
            print("Erro ao buscar pecados: \(error)")
            return nil
        }
    }
    
    func fetchSinByDescription(_ description: String) -> Sin? {
        let request: NSFetchRequest<Sin> = Sin.fetchRequest()
        request.predicate = NSPredicate(format: "sinDescription == %@", description)
        
        do {
            let result = try context.fetch(request)
            return result.first
        } catch {
            print("Erro ao buscar pecado por descrição: \(error)")
            return nil
        }
    }
    
    // MARK: - UPDATE
    func updateSin(_ sin: Sin, isConfessed: Bool? = nil, sinDescription: String? = nil) {
        if let isConfessed = isConfessed {
            sin.isConfessed = isConfessed
        }
        
        if let sinDescription = sinDescription {
            sin.sinDescription = sinDescription
        }
        
        do {
            try context.save()
        } catch {
            print("Erro ao atualizar pecado: \(error)")
        }
    }
    
    // MARK: - DELETE
    func deleteSin(_ sin: Sin) {
        context.delete(sin)
        
        do {
            try context.save()
        } catch {
            print("Erro ao deletar pecado: \(error)")
        }
    }
    
    // MARK: - DELETE ALL
    func deleteAllSins() {
        let request: NSFetchRequest<NSFetchRequestResult> = Sin.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try context.execute(deleteRequest)
        } catch {
            print("Erro ao deletar todos os pecados: \(error)")
        }
    }
}
