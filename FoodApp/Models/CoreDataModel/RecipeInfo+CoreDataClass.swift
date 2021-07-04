//
//  RecipeInfoCD+CoreDataClass.swift
//  
//
//  Created by maxim panteleev on 02.07.2021.
//
//

import Foundation
import CoreData


public class RecipeInfoCD: NSManagedObject, Info {

    func setProperties(recipe: Info, user: UserCD) {
        id = recipe.id
        image = recipe.image
        readyInMinutes = recipe.readyInMinutes
        sourceUrl = recipe.sourceUrl
        summary = recipe.summary
        title = recipe.title
        self.user = user
    }
}
