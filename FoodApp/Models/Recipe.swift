//
//  Recipe.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import Foundation

struct Recipe: Decodable {
    
    let id: Int
    let title: String
    let image: String
    let imageType: String
}
