//
//  FavoriteCell.swift
//  FoodApp
//
//  Created by maxim panteleev on 03.07.2021.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    
    static let reuseId = "FavoriteCell"
    
    var mealImage = MealImage(frame: .zero)
    var recipeName = FLabel(fontSize: 20, weight: .medium, alignment: .natural)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(mealImage, recipeName)
        mealImage.layer.borderWidth = 2
        mealImage.layer.borderColor = UIColor.lightGray.cgColor
        recipeName.numberOfLines = 2
        recipeName.lineBreakMode = .byTruncatingTail
        
        NSLayoutConstraint.activate([
            mealImage.topAnchor.constraint(equalTo: self.topAnchor),
            mealImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mealImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mealImage.heightAnchor.constraint(equalToConstant: 150),
            
            recipeName.topAnchor.constraint(equalTo: mealImage.bottomAnchor, constant: 2),
            recipeName.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recipeName.centerXAnchor.constraint(equalTo: mealImage.centerXAnchor),
            recipeName.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func set(recipe: RecipeInfoCD) {
        mealImage.downloadImage(fromURL: recipe.image)
        recipeName.text = recipe.title
    }
}
