//
//  CoreDataManager.swift
//  FoodApp
//
//  Created by maxim panteleev on 02.07.2021.
//

import Foundation
import CoreData


class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    
    // MARK: - Core Data stack
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Recipe")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = persistentContainer.viewContext
    
    
    // MARK: - CRUD
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("saved")
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // check if user with current uid is already exist in database
    func userUidCheck() -> UserCD {
        let fetchRequest = NSFetchRequest<UserCD>(entityName: "UserCD")
        let id = AuthenticationManager.user!.uid
        fetchRequest.predicate = NSPredicate(format: "uid = %@", id)
        do {
            let users = try context.fetch(fetchRequest) as [UserCD]
            guard let user = users.first else {
                let user = UserCD(context: context)
                user.uid = id
                return user
            }
            return user
        } catch {
            fatalError("Something bad happened")
        }
    }
    
    
    func fetchRecipes(completed: @escaping ([RecipeInfoCD]) -> Void){
        let user = userUidCheck()
        guard let recipes = user.recipe else { return }
        var result = [RecipeInfoCD]()
        for item in recipes {
            result.append(item as! RecipeInfoCD)
        }
        completed(result)
    }
    
    func save(recipe: Info) {
        let userCD = userUidCheck()
        let recipeInfoCD = RecipeInfoCD(context: context)
        recipeInfoCD.setProperties(recipe: recipe, user: userCD)
        userCD.addToRecipe(recipeInfoCD)
        saveContext()
    }
    
    func delete(recipe: Info) {
        let userCD = userUidCheck()
        guard let r = userCD.recipe?.filter({ ($0 as! Info).id == recipe.id}).first as? RecipeInfoCD else { return }
        context.delete(r)
        saveContext()
    }
}
