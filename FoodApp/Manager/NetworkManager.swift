//
//  NetworkManager.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    private let urlStr = "https://api.spoonacular.com/recipes/complexSearch?query=pasta&apiKey=a08b1472ffe042e992008c5ade01dcbe"
    
    func getRecipe() {
        guard let url = URL(string: urlStr) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, _ in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            var recipes = [Recipe]()
            let result = try? JSONDecoder().decode(Result.self, from: data)
            recipes = result?.results ?? [Recipe]()
            print(response)
            print("-----------------")
            print(data)
            print("-----------------")
            print(recipes)
        }.resume()
    }
}
