/* 
Copyright (c) 2021 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct DescriptionResponseBase : Mappable {
	var type : String?
	var title : String?
	var displaytitle : String?
	var namespace : Namespace?
	var wikibase_item : String?
	var titles : Titles?
	var pageid : Int?
	var thumbnail : Thumbnail?
	var originalimage : Originalimage?
	var lang : String?
	var dir : String?
	var revision : String?
	var tid : String?
	var timestamp : String?
	var description : String?
	var description_source : String?
	var coordinates : Coordinates?
	var content_urls : Content_urls?
	var extract : String?
	var extract_html : String?

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		type <- map["type"]
		title <- map["title"]
		displaytitle <- map["displaytitle"]
		namespace <- map["namespace"]
		wikibase_item <- map["wikibase_item"]
		titles <- map["titles"]
		pageid <- map["pageid"]
		thumbnail <- map["thumbnail"]
		originalimage <- map["originalimage"]
		lang <- map["lang"]
		dir <- map["dir"]
		revision <- map["revision"]
		tid <- map["tid"]
		timestamp <- map["timestamp"]
		description <- map["description"]
		description_source <- map["description_source"]
		coordinates <- map["coordinates"]
		content_urls <- map["content_urls"]
		extract <- map["extract"]
		extract_html <- map["extract_html"]
	}

}
