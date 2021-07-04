//
//  NetworkManager.swift
//  FoodApp
//
//  Created by maxim panteleev on 19.06.2021.
//

import Foundation

struct NetworkManager {
    
    static let shared = NetworkManager()
    
    func getRecipe(query: String, completed: @escaping (Result<[Recipe], FError>) -> Void) {
        guard let url = Endpoint.search(matching: query, searchType: .recipes).url else {
            completed(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let result = try JSONDecoder().decode(SearchResult.self, from: data)
                let recipes = result.results
                completed(.success(recipes))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func getRecipeInfo(for id: Int, completed: @escaping (Result<RecipeInfo, FError>) -> Void) {
        guard let url = Endpoint.search(matching: String(id), searchType: .recipeInfo).url else {
            completed(.failure(.invalidUrl))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            do {
                let recipe = try JSONDecoder().decode(RecipeInfo.self, from: data)
                completed(.success(recipe))
            } catch {
                completed(.failure(.invalidData))
            }
        }.resume()
    }
    
    func downloadImage(from urlString: String, completed: @escaping (Data) -> Void) {
        guard let url = URL(string: urlString) else { print("invalid url"); return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else { print("invalid data"); return }
            completed(data)
        }.resume()
    }
}
