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
            self.getJSON()
            
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

    func getJSON() { // -> [lugares] {
        
        if let url = URL(string: "https://me-leva-rio.firebaseio.com/0.json") {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    print("Sucesso")
                    
                    if let data = data {
                        
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: data, options: [])
                            print(jsonResult)
                            
                        } catch  {
                            
                            print("Erro no retorno")
                            
                        }
                    }

                } else {
                    print("Erro!")
                    
                    return ()
                }
                
            }
            
            task.resume()
            
        }
    }
}
