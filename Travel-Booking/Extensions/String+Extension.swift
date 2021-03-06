//
//  ReadJSON.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 28/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation

extension String {
    func readAirlinesJSON() -> String {
        var code = ""
        if let path = Bundle.main.path(forResource: "Airline", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]] {
                    
                    let codeVal = jsonObj.filter {
                        $0["name"] as! String == self
                    }.first
                    
                    if let _ = codeVal {
                        code = codeVal!["code"] as! String
                    }
                }
                
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return code
    }
}
