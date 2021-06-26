//
//  FButton.swift
//  FoodApp
//
//  Created by maxim panteleev on 22.06.2021.
//

import UIKit

class FButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String){
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        configure()
    }
    
    func configure()  {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGreen.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        backgroundColor = .systemGreen
    }
}
