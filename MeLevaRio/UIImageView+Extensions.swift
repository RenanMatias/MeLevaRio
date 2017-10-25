//
//  UIImageView+Extensions.swift
//  FeaturedGames
//
//  Created by Cauê Silva on 04/08/17.
//  Copyright © 2017 Caue Alves. All rights reserved.
//

import Foundation
import UIKit
import PINCache
import PINRemoteImage

extension UIImageView {
    
    func downloadImage(with url: String) {
        pin_updateWithProgress = true
        pin_setImage(from: URL(string: url))
    }
    
}
