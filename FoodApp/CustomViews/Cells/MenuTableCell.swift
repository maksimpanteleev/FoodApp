//
//  MenuCell.swift
//  FoodApp
//
//  Created by maxim panteleev on 26.06.2021.
//

import UIKit

class MenuTableCell: UITableViewCell {

    static let reuseId = "MenuTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        textLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
