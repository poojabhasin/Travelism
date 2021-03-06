//
//  CreateAttributedString.swift
//  Travel-Booking
//
//  Created by iOS_Dev on 25/02/21.
//  Copyright © 2021 Pooja Bhasin. All rights reserved.
//

import Foundation
import UIKit

class Common {
    
    static func getAttributedString(spacing:CGFloat, val1:String, val2:String)->NSMutableAttributedString?{
        
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = spacing
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping
        
        guard
            let medium = UIFont(name: "HelveticaNeue", size: 14),
            let light = UIFont(name: "HelveticaNeue-Medium", size: 22)  else { return nil}
        
        let keyAttributes: [NSAttributedString.Key: Any] = [.font:medium ,
                                                            .paragraphStyle: style,
                                                            .foregroundColor:UIColor.black]
        
        let valueAttributes: [NSAttributedString.Key: Any] = [.font: light,
                                                              .paragraphStyle: style,
                                                              .foregroundColor:UIColor.black]
        
        let attString = NSMutableAttributedString()
        attString.append(NSAttributedString(string: " \t   "))
        attString.append(NSAttributedString(string: val1 , attributes: keyAttributes))
        attString.append(NSAttributedString(string: "\n"))
        attString.append(NSAttributedString(string: " \t   "))
        attString.append(NSAttributedString(string: val2 , attributes: valueAttributes))
        attString.append(NSAttributedString(string: " \t \t \t \t \t \t \t"))
        
        return attString
    }
    
    static func getAttributedStringForFlights(spacing:CGFloat, val1:String, val2:String, val3:String)->NSMutableAttributedString?{
        
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = spacing
        style.alignment = .left
        style.lineBreakMode = .byWordWrapping
        
        guard
            let small = UIFont(name: "HelveticaNeue", size: 14),
            let medium = UIFont(name: "HelveticaNeue-Medium", size: 22),
            let light = UIFont(name: "HelveticaNeue", size: 16)else { return nil}
        
        let smallAttributes: [NSAttributedString.Key: Any] = [.font:small ,
        .paragraphStyle: style,
        .foregroundColor:UIColor.black]
        
        let keyAttributes: [NSAttributedString.Key: Any] = [.font:medium ,
                                                            .paragraphStyle: style,
                                                            .foregroundColor:UIColor.black]
        
        let valueAttributes: [NSAttributedString.Key: Any] = [.font: light,
                                                              .paragraphStyle: style,
                                                              .foregroundColor:UIColor.black]
        
        let attString = NSMutableAttributedString()
        attString.append(NSAttributedString(string: val1 , attributes: smallAttributes))
        attString.append(NSAttributedString(string: "\n"))
        attString.append(NSAttributedString(string: val2.uppercased() , attributes: keyAttributes))
        attString.append(NSAttributedString(string: "\n"))
        attString.append(NSAttributedString(string: val3 , attributes: valueAttributes))

        return attString
    }

    static func currentDate()->String {
        var date: String?
        if let monthInt = Calendar.current.dateComponents([.month], from: Date()).month {
            let monthStr = Calendar.current.monthSymbols[monthInt-1]
            let yearInt = Calendar.current.dateComponents([.year], from: Date()).year
            let day = Calendar.current.dateComponents([.day], from: Date()).day
            let first3 = String(monthStr.prefix(3))
            date = "\(day ?? 1) \(first3) \(yearInt ?? 2021)"
        }
        return date ?? ""
    }
    
    static func searchedDate()->String {
        let date = Date()
        let dateformat = DateFormatter()
        dateformat.dateFormat = "yyyy-MM-dd"
        return dateformat.string(from: date)
    }
    
    static func getIndexedCharsFromString(noOfIndex: Int, value: String)->String {
        let result = String(value.prefix(noOfIndex))
        return result
    }
    
    static func removeWhitespaces(val: String)->String {
        let newStr = val.replacingOccurrences(of: " ", with: "")
        return newStr
    }

}
