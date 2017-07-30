//
//  MeLevaRioRequest.swift
//  MeLevaRio
//
//  Created by Renan Matias on 27/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import Foundation
import ObjectMapper

public typealias JSONDictionary = [String: Any]
typealias ModelRemoteServiceCompletion = (_ objects: [lugares]?, _ error: Error?) -> Void

class LugaresRequest {
    
    required init() { }
    
    func downloadObjects(_ completion: @escaping ModelRemoteServiceCompletion) {
        DispatchQueue.global().async {
            
            // REQUEST
            self.getJSON({ lugares in
                completion(lugares, nil)
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

    func getJSON(_ completion: @escaping (_ lugares: [lugares]) -> Void) {
        
        if let url = URL(string: "https://me-leva-rio.firebaseio.com/.json") {
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if error == nil {
                    print("Sucesso")
                    
                    if let data = data {
                        
                        do {
                            
                            let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [JSONDictionary]
                            let lugaresResult = jsonResult.flatMap { lugares(map: Map(mappingType: .fromJSON, JSON: $0)) }
                            completion(lugaresResult)
                            
                            
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
