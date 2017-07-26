//
//  ViewController.swift
//  MeLevaRio
//
//  Created by Renan Matias on 27/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit
//import Firebase

struct lugarViewDTO {
    var descricao = ""
    var latitude = 0
    var longitude = 0
    var mainImage = ""
    var nome = ""
    var images: [String]?
}

class ViewController: UIViewController, LugaresDelegate {
    
    lazy var viewModel : LugaresViewModel = LugaresViewModel(delegate: self)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let ref = FIRDatabase.database().reference()
        
        downloadLugares()
    }
    
    func downloadLugares() {
        viewModel.downloadObjects()
    }
    
    
    //MARK: LugaresDelegate
    func updateInterface(success: Bool) {
        
        DispatchQueue.main.async {
            if success {
                
                let dto = self.viewModel.getLugaresDTO()
                
                print(dto.nome)
                
                if let images = dto.images {
                    for image in images {
                        print(image)
                    }
                }
                
            } else {
                
                self.showAlert()
                
            }
        }
        
    }
    
    func showAlert() {
        
        showNativeAlert(title: "Aviso",
                        message: "Erro de conexão",
                        afirmativeAction: "Tentar novamente",
                        negativeAction: "Cancelar") { action in
                            if action.title == "Tentar novamente" {
                                self.downloadLugares()
                            } else if action.title == "Cancelar" {
//                                code
                            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

