//
//  BookingConfirmationViewController.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 04/03/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import UIKit

class BookingConfirmationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func backBtnPressed(_ sender: Any) {
        
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)

    }
}
