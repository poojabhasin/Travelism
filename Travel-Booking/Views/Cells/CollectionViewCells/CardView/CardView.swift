//
//  CardView.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 17/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit
import Kingfisher
import FSPagerView

class CardView: FSPagerViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var imageParentView: UIView!
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    
    var city: String? {
        didSet {
            self.cityName.text = city
            
            self.contentView.layer.cornerRadius = 20.0
            self.contentView.layer.borderWidth = 1.0
            self.contentView.layer.borderColor = UIColor.clear.cgColor
            self.contentView.layer.masksToBounds = true
            
            self.layer.cornerRadius = 20.0
                        
            cityImage.layer.cornerRadius = 20.0
            cityImage.layer.masksToBounds = true
            
            self.applyShadow()
            self.imageParentView.applyShadow()
        }
    }
    
    
    var reference_id: String? {
        didSet {
            let urlStr = ServerRequestRouter.getImageFromReferenceId(reference_id!).path
            let url = NSURL(string: urlStr)! as URL
            
            self.cityImage.kf.setImage(with: url)
        }
    }
    
}

