//
//  RecipeInfo.swift
//  FoodApp
//
//  Created by maxim panteleev on 02.07.2021.
//

import Foundation

protocol Info {
    var id: Int32 { get }
    var image: String { get }
    var readyInMinutes: Int16 { get }
    var sourceUrl: String { get }
    var summary: String { get }
    var title: String { get }
}

struct RecipeInfo: Decodable, Info {
    var id: Int32
    var image: String
    var readyInMinutes: Int16
    var sourceUrl: String
    var summary: String
    var title: String
    
}
