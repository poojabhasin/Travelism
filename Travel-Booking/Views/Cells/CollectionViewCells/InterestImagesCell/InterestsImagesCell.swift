//
//  InterestsImagesCell.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 25/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class InterestsImagesCell: UICollectionViewCell {
    
    @IBOutlet weak var starBtn: UIButton! {
        didSet {
            self.starBtn.layer.cornerRadius = 10.0
            self.starBtn.layer.borderWidth = 0.6
            self.starBtn.layer.borderColor = UIColor.white.cgColor
        }
    }
    

    @IBOutlet weak var interestImg: UIImageView! {
        didSet {
            self.interestImg.layer.cornerRadius = 20.0
            self.interestImg.layer.masksToBounds = true

        }
    }
    
    @IBOutlet weak var nameOfInterest: UILabel! {
        didSet {
            nameOfInterest.layer.cornerRadius = 20.0
            nameOfInterest.layer.masksToBounds = true
        }
    }
    
    var reference_id: String? {
           didSet {
               let urlStr = ServerRequestRouter.getImageFromReferenceId(reference_id!).path
               let url = NSURL(string: urlStr)! as URL
               
               self.interestImg.kf.setImage(with: url)
           }
    }
    
    
    
    
}
