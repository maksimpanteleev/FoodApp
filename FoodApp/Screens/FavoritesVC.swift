//
//  FavoritesVC.swift
//  FoodApp
//
//  Created by maxim panteleev on 26.06.2021.
//

import UIKit
import WebKit

class FavoritesVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, RecipeInfoCD>!
    var recipes = [RecipeInfoCD]()
    
    var recipeAtIndexToDelete: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteRecipes()
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a recipe"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = true
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
    }
    
    func configureCollectionView() {
        let width = view.bounds.width
        let padding: CGFloat = 15
        let availableWidth = width - (padding * 3)
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding * 2, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.register(FavoriteCell.self, forCellWithReuseIdentifier: FavoriteCell.reuseId)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, RecipeInfoCD>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, recipe) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCell.reuseId, for: indexPath) as! FavoriteCell
            cell.set(recipe: self.recipes[indexPath.item])
            return cell
        })
    }
    
    func updateData(recipes: [RecipeInfoCD]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, RecipeInfoCD>()
        snapshot.appendSections([.main])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    func getFavoriteRecipes() {
        CoreDataManager.shared.fetchRecipes { recipes in
            self.recipes = recipes
            self.updateData(recipes: recipes)
        }
    }
}

extension FavoritesVC: UICollectionViewDelegate {
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.async {
            let recipeVC = RecipeVC(recipe: self.recipes[indexPath.item], buttonType: .delete)
            recipeVC.delegate = self
            self.recipeAtIndexToDelete = indexPath.item
            let navVC = UINavigationController(rootViewController: recipeVC)
            self.present(navVC, animated: true, completion: nil)
        }
    }
}

extension FavoritesVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text else { return }
        if !filter.isEmpty {
            let filteredRecipes = recipes.filter{ $0.title.contains(filter) }
            updateData(recipes: filteredRecipes)
        } else {
            updateData(recipes: recipes)
        }
    }
}

extension FavoritesVC: RecipeVCDelegate{
    
    func deleteTapped() {
        recipes.remove(at: recipeAtIndexToDelete)
        DispatchQueue.main.async {
            self.updateData(recipes: self.recipes)
        }
    }
}
