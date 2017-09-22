//
//  LugarView.swift
//  MeLevaRio
//
//  Created by Renan Matias on 17/08/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit
import MapKit

class LugarView: UIView {

    // MARK: Outlets
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var nomeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func awakeFromNib() { // DID LOAD
        super.awakeFromNib()
        self.setFormatImageView()
    }
    
    private func setFormatImageView() {
        
       mainImageView.roundedFormat()

    }
    
    func fill(dto: lugarViewDTO, myLocation: CLLocationCoordinate2D) {
        mainImageView.downloadImage(with: dto.mainImage)
        nomeLabel.text = dto.nome
        
        let sourceCoordinate = CLLocation(latitude: myLocation.latitude, longitude: myLocation.longitude)
        let destinationCoordinate = CLLocation(latitude: dto.latitude, longitude: dto.longitude)

        let distanceInMeters = Int(sourceCoordinate.distance(from: destinationCoordinate)) / 1000

        distanceLabel.text = "\(distanceInMeters) Km"
        
    }

}
