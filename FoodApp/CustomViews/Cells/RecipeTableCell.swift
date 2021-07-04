//
//  RecipeCell.swift
//  FoodApp
//
//  Created by maxim panteleev on 27.06.2021.
//

import UIKit

class RecipeTableCell: UITableViewCell {

    static let reuseId = "RecipeTableCell"
    var mealImage = MealImage(frame: .zero)
    var mealName = FLabel(fontSize: 26, weight: .regular, alignment: .left)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubviews(mealName, mealImage)
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            mealImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            mealImage.heightAnchor.constraint(equalToConstant: 60),
            mealImage.widthAnchor.constraint(equalToConstant: 60),
            
            mealName.leadingAnchor.constraint(equalTo: mealImage.trailingAnchor, constant: padding),
            mealName.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            mealName.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            mealName.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func set(recipe: Recipe) {
        mealImage.downloadImage(fromURL: recipe.image)
        mealName.text = recipe.title
    }
}
