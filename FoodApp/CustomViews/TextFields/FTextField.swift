//
//  FTextField.swift
//  FoodApp
//
//  Created by maxim panteleev on 22.06.2021.
//

import UIKit

class FTextField: UITextField {

    override init(frame: CGRect){
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(placeholder: String, isSecure: Bool) {
        self.init(frame: .zero)
        self.placeholder = placeholder
        isSecureTextEntry = isSecure
    }
    
    func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray3.cgColor
        
        autocorrectionType = .no
        clearButtonMode = .whileEditing
        returnKeyType = .go
        
        backgroundColor = .systemBackground
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title1)
        minimumFontSize = 10
        autocapitalizationType = .none
        adjustsFontSizeToFitWidth = true
    }
}
