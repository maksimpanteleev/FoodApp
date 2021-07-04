//
//  SearchVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 22.06.2021.
//

import UIKit

class SearchVC: UIViewController {
    
    let searchBar = UISearchBar()
    var recipes = [Recipe]()
    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        configureUI()
        configureTableView()
    }
    
    
    private func configureUI() {
        view.addSubview(searchBar)
        searchBar.placeholder = "Search for a meal"
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecipeTableCell.self, forCellReuseIdentifier: RecipeTableCell.reuseId)
        
        tableView.rowHeight = 70
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func getRecipes(query: String) {
        NetworkManager.shared.getRecipe(query: query) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.presentAlertVC(title: "Something went wrong.", message: error.rawValue)
            case .success(let recipes):
                self.updateUI(with: recipes)
            }
        }
    }
    
    private func updateUI(with recipes: [Recipe]) {
        self.recipes = recipes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            presentAlertVC(title: "Empty search field.", message: "Print recipe name.")
            return
        }
        getRecipes(query: query)
        searchBar.resignFirstResponder()
    }
}

extension SearchVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecipeTableCell.reuseId, for: indexPath) as! RecipeTableCell
        cell.set(recipe: recipes[indexPath.row])
        return cell
    }
}

extension SearchVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = recipes[indexPath.row].id
        NetworkManager.shared.getRecipeInfo(for: id) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let recipe):
                DispatchQueue.main.async {
                    let recipeVC = RecipeVC(recipe: recipe, buttonType: .add)
                    let navVC = UINavigationController(rootViewController: recipeVC)
                    self.present(navVC, animated: true, completion: nil)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presentAlertVC(title: "Something went wrong", message: error.rawValue)
                }
            }
        }
    }
}
