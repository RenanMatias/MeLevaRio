//
//  UIViewController+Extensions.swift
//  InfoBooks
//
//  Created by Renan Matias on 08/06/17.
//  Copyright © 2017 Renan Matias. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showNativeAlert(title: String, message: String, afirmativeAction: String, negativeAction: String, completeBlock: ((UIAlertAction) -> Void)?) {
        
        // MAIN THREAD (ATUALIZAÇÃO DE INTERFACE)
        
        DispatchQueue.main.async {
            // CRIAR ALERT CONTROLLER
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let yesAction = UIAlertAction(title: afirmativeAction, style: .default, handler: completeBlock)
            let notAction = UIAlertAction(title: negativeAction, style: .destructive, handler: completeBlock)
            alertController.addAction(notAction)
            alertController.addAction(yesAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showSimpleAlert(title: String, message: String, button: String, completeBlock: ((UIAlertAction) -> Void)?) {
        
        // MAIN THREAD (ATUALIZAÇÃO DE INTERFACE)
        
        DispatchQueue.main.async {
            // CRIAR ALERT CONTROLLER
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: button, style: .default, handler: completeBlock)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
}
