//
//  ShadowView.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 19/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func applyShadow() {
          
           self.layer.borderWidth = 0.0
           self.layer.shadowColor = UIColor.darkGray.cgColor
           self.layer.shadowOffset = CGSize(width: 0, height: 0)
           self.layer.shadowRadius = 5.0
           self.layer.shadowOpacity = 0.5
           self.layer.masksToBounds = false
    }
    
}
