//
//  FLabel.swift
//  FoodApp
//
//  Created by maxim panteleev on 27.06.2021.
//

import UIKit

class FLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    convenience init(fontSize: CGFloat, weight: UIFont.Weight, alignment: NSTextAlignment) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        textAlignment = alignment
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        adjustsFontForContentSizeCategory = true
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
        lineBreakMode = .byTruncatingTail
    }
}
