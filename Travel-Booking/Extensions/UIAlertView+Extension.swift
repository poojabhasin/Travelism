//
//  UIAlertView+Extension.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 03/03/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import UIKit
import FCAlertView

extension UIViewController {
    
    func showErrorAlertWithTitle(_ title:String?, message:String) {
        let alert = FCAlertView()
        alert.colorScheme = UIColor(red: 182/255, green: 50/255, blue: 38/255, alpha: 0.9)
        alert.showAlert(withTitle: title, withSubtitle: message, withCustomImage: #imageLiteral(resourceName: "Error"), withDoneButtonTitle: nil, andButtons: nil)
        
    }
    
    func showAlertWithForSucess(_ title:String?,message: String){
        
        let alert = FCAlertView()
        alert.colorScheme = UIColor(red: 25/255, green: 180/255, blue: 145/255, alpha: 0.9)
        alert.showAlert(withTitle: title, withSubtitle: message, withCustomImage: #imageLiteral(resourceName: "Success"), withDoneButtonTitle: nil, andButtons: nil)
    }
    
}
