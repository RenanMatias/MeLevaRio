//
//  Lugares.swift
//  MeLevaRio
//
//  Created by Renan Matias on 27/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import Foundation
import ObjectMapper

struct lugares: Mappable {
    
    // PROPERTIES
    
    var lugar: lugar?

    // INIT
    
    init?(map: Map) {
        mapping(map: map)
    }
    
    // SERIALIZE
    
    mutating func mapping(map: Map) {
        lugar     <- map["lugar"]
    }
    
}
