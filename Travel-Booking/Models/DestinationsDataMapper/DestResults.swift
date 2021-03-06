/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct DestResults : Mappable, Equatable {
    static func == (lhs: DestResults, rhs: DestResults) -> Bool {
        if lhs.name == rhs.name {
            return true
        }
        return false
    }
    
	var business_status : String?
	var formatted_address : String?
	var icon : String?
	var name : String?
	var photos : [DestPhotos]?
	var place_id : String?
	var rating : Double?
	var reference : String?
	var types : [String]?
	var user_ratings_total : Int?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		business_status <- map["business_status"]
		formatted_address <- map["formatted_address"]
		icon <- map["icon"]
		name <- map["name"]
		photos <- map["photos"]
		place_id <- map["place_id"]
		rating <- map["rating"]
		reference <- map["reference"]
		types <- map["types"]
		user_ratings_total <- map["user_ratings_total"]
	}

}
