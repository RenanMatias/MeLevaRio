//
//  MeLevaRioRequest.swift
//  MeLevaRio
//
//  Created by Renan Matias on 27/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import Foundation
import ObjectMapper
import Firebase

public typealias JSONDictionary = [String: Any]
typealias ModelRemoteServiceCompletion = (_ objects: [lugares]?, _ error: Error?) -> Void

class LugaresRequest {
    
    required init() { }
    
    func downloadObjects(_ completion: @escaping ModelRemoteServiceCompletion) {
        DispatchQueue.global().async {
            
            // REQUEST
            let ref = FIRDatabase.database().reference()
            let lugaresRef = ref.child("0")
        
            lugaresRef.observe(FIRDataEventType.value, with: { (dados) in
                
                print(dados.value)
                
            })
            
//            completion(self.mockJSON(), nil)
        }
    }
    
    func mockJSON() -> [lugares] {
        let path = Bundle.main.path(forResource: "me-leva-rio-export", ofType: "json")
        let data = try! Data(contentsOf: URL(fileURLWithPath: path!))
        let jsonResult = try! JSONSerialization.jsonObject(with: data, options: []) as! [JSONDictionary]
        let lugaresResult = jsonResult.flatMap { lugares(map: Map(mappingType: .fromJSON, JSON: $0)) }
        return lugaresResult
    }
    
}
