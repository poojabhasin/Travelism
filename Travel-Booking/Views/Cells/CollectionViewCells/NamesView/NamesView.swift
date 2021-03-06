//
//  NamesView.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 17/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class NamesView: UICollectionViewCell {
    
    @IBOutlet weak var dottedLbl: UILabel! {
        didSet {
            self.dottedLbl.layer.cornerRadius = self.dottedLbl.frame.width/2
            self.dottedLbl.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var countriesName: UILabel!
    
    
}
