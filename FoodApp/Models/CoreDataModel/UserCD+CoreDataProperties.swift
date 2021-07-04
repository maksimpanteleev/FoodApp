//
//  UserCD+CoreDataProperties.swift
//  
//
//  Created by maxim panteleev on 02.07.2021.
//
//

import Foundation
import CoreData


extension UserCD {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserCD> {
        return NSFetchRequest<UserCD>(entityName: "UserCD")
    }

    @NSManaged public var uid: String
    @NSManaged public var recipe: NSSet?

}

// MARK: Generated accessors for recipe
extension UserCD {

    @objc(addRecipeObject:)
    @NSManaged public func addToRecipe(_ value: RecipeInfoCD)

    @objc(removeRecipeObject:)
    @NSManaged public func removeFromRecipe(_ value: RecipeInfoCD)

    @objc(addRecipe:)
    @NSManaged public func addToRecipe(_ values: NSSet)

    @objc(removeRecipe:)
    @NSManaged public func removeFromRecipe(_ values: NSSet)

}
