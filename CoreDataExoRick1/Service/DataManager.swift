//
//  DataManager.swift
//  CoreDataExoRick1
//
//  Created by roman domasik on 16/02/2024.
//

import Foundation
import CoreData

class DataManager{
    
    static let shared = DataManager()
    
    let context: NSManagedObjectContext
    
    init() {
        let container = NSPersistentContainer(name: "Favorite")
        let dbFileURL = FileManager.default
                    .urls(for: .documentDirectory, in: .userDomainMask)[0]
                    .appendingPathComponent("favoritedb.sqlite")
                
                let storeDescription = NSPersistentStoreDescription(url: dbFileURL)
                storeDescription.type = NSSQLiteStoreType
                container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        context = container.viewContext
    }
    
    private func saveContext(){
        guard context.hasChanges else { return }
        do{
            try context.save()
        } catch{
            print("error saviong context", error)
        }
    }
    
    func addFavorite(name: String){
        let favorite = Favorite(context: context)
        favorite.name = name
        saveContext()
    }
    
    func deleteFavorite(_ favorite: Favorite){
        context.delete(favorite)
        saveContext()
    }
    
    func deleteFavoriteWithName(name: String) {
            let request = NSFetchRequest<Favorite>(entityName: "Favorite")
            request.predicate = NSPredicate(format: "name == %@", name)

            do {
                let favorites = try context.fetch(request)

                // Supprimez tous les favoris correspondant au nom spécifié
                for favorite in favorites {
                    context.delete(favorite)
                }

                try context.save()
            } catch {
                print("Error deleting favorite: \(error)")
            }
        }
    
}
