//
//  Result.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import Foundation

struct SearchResult: Decodable {
    
    let results: [Recipe]
    let offset: Int
    let number: Int
    let totalResults: Int
}
