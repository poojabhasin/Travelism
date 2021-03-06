//
//  UISpinner+Extension.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 03/03/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    func showSpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        

        
        let ai = UIActivityIndicatorView()
        ai.style = UIActivityIndicatorView.Style.large
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        return spinnerView
    }
    
    func removeSpinner(spinner:UIView?) {
        DispatchQueue.main.async {
            spinner?.removeFromSuperview()
        }
    }
}
