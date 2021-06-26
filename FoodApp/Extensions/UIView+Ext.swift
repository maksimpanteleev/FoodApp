//
//  UIView+Ext.swift
//  FoodApp
//
//  Created by maxim panteleev on 22.06.2021.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...){
        for view in views {
            addSubview(view)
        }
    }
}
