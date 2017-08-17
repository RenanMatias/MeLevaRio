//
//  UIView+Extension.swift
//  Jobs Test
//
//  Created by Cauê Silva on 11/05/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    // CELL ADD ESSA VIEW COMO UMA SUBVIEW
    func fillWithSubview(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addSubview(subview)
        
        // VIEW VAI TER ALTURA IGUAL A DA CELL
        // VIEW VAI TER COMPRIMENTO IGUAL A DA CELL
        let views = ["view": subview]
        let vC = NSLayoutConstraint.constraints(withVisualFormat: "V:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        let hC = NSLayoutConstraint.constraints(withVisualFormat: "H:|[view]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        
        addConstraints(vC)
        addConstraints(hC)
        updateConstraints()
        
        subview.setNeedsDisplay()
        layoutIfNeeded()
    }
    
    // CELL CHAMA ESSA EXTENSION PASSANDO UMA VIEW COMO PARAMETRO
    class func fromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)!.first as! T
    }
    
}
