//
//  LugarTableViewCell.swift
//  MeLevaRio
//
//  Created by Renan Matias on 17/08/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit
import MapKit

class LugarTableViewCell: UITableViewCell {

    let view: LugarView = UIView.fromNib()

    // View Lyfe of Circle
    
    override func awakeFromNib() { //Did Load
        super.awakeFromNib()
        // Initialization code
        
        self.fillWithSubview(subview: view)
        
    }

    func fill(dto: lugarViewDTO, myLocation: CLLocationCoordinate2D) {
        view.fill(dto: dto, myLocation: myLocation)
    }

}
