//
//  DestinationsView.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 17/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class DestinationsView: UICollectionViewCell {
    
    @IBOutlet weak var parentView: UIView! {
        didSet {
            self.layer.cornerRadius = 20.0
            self.layer.masksToBounds = true
            destinationImage.layer.cornerRadius = 20.0
            destinationImage.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var destinationImage: UIImageView!
    @IBOutlet weak var destinationsName: UILabel!
    
    var reference_id: String? {
        didSet {
            let urlStr = ServerRequestRouter.getImageFromReferenceId(reference_id!).path
            let url = NSURL(string: urlStr)! as URL
            
            self.destinationImage.kf.setImage(with: url)
        }
    }
}
