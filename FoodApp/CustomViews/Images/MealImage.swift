//
//  MealImage.swift
//  FoodApp
//
//  Created by maxim panteleev on 27.06.2021.
//

import UIKit

class MealImage: UIImageView {
    
    let placeholder = UIImage(systemName: "photo")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        image = placeholder
        layer.cornerRadius = 10
        clipsToBounds = true
    }
    
    func downloadImage(fromURL url: String) {
        NetworkManager.shared.downloadImage(from: url) { [weak self] data in
            guard let self = self else { return }
            
            guard let uiImage = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = uiImage
            }
        }
    }
}
