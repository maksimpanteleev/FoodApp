//
//  EndPoints.swift
//  FoodApp
//
//  Created by maxim panteleev on 28.06.2021.
//

import Foundation

struct Endpoint {
    
    enum Path: String {
        case recipes
        case recipeInfo
    }
    let path: String
    let queryItems: [URLQueryItem]
}
    
extension Endpoint {
    static func search(matching query: String, searchType: Path) -> Endpoint {
        switch searchType {
        case .recipes:
            return Endpoint(
                path: "/recipes/complexSearch",
                queryItems: [
                    URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "apiKey", value: "a08b1472ffe042e992008c5ade01dcbe")
                ]
            )
        case .recipeInfo:
            return Endpoint(
                path: "/recipes/\(query)/information",
                queryItems: [
                    URLQueryItem(name: "apiKey", value: "a08b1472ffe042e992008c5ade01dcbe")
                ]
            )
        }
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.spoonacular.com"
        components.path = path
        components.queryItems = queryItems

        return components.url
    }
}
