//
//  Lugar.swift
//  MeLevaRio
//
//  Created by Renan Matias on 28/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import Foundation
import ObjectMapper

struct lugar: Mappable {
    
    // PROPERTIES
    
    var descricao = ""
    var latitude = 0
    var longitude = 0
    var mainImage = ""
    var nome = ""
    var images: [String] = []
    

    
    // INIT
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    // SERIALIZE
    
    mutating func mapping(map: Map) {
        descricao       <- map["descricao"]
        latitude        <- map["latitude"]
        longitude       <- map["longitude"]
        mainImage       <- map["mainImage"]
        nome            <- map["nome"]
        images          <- map["images"]
    }
    
}
