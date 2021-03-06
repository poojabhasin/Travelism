//
//  FlightDetailsCell.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 26/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit
import Kingfisher

class FlightDetailsCell: UITableViewCell {
    
    @IBOutlet weak var detailsView: UIView! {
        didSet {
            self.detailsView.layer.cornerRadius = 25
        }
    }
    @IBOutlet weak var flightImage: UIImageView!
    
    @IBOutlet weak var flightsourceDestLbl: UILabel!
    
    @IBOutlet weak var flightChrages: UILabel!
    
    @IBOutlet weak var flightTimingTxt: UILabel!
    
    var code: String? {
        didSet {
            let urlStr = "\(ServerRequestRouter.airlineImageURL)\(String(describing: code!))"
            let url = NSURL(string: urlStr)! as URL
            
            self.flightImage.kf.setImage(with: url)
        }
    }
}
