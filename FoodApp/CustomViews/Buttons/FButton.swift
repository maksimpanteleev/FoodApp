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
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String){
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    func configure()  {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 8
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        backgroundColor = .systemTeal
    }
}
