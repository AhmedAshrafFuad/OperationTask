//
//  UIViewController+UIAlertController.swift
//  OperationsTask
//
//  Created by AHMED ASHRAF on 27/12/2020.
//

import UIKit

extension UIViewController{
    
    func showAlert(title:String,body:String){
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Ok", comment: ""), style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlert(title:String, body:String, buttonTitle: String, buttonHandler:@escaping ()->()){
        let alert = UIAlertController(title: title, message: body, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
            buttonHandler()
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    
    
}
