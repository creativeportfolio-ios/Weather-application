//
//	Weather.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Weather : NSObject, Mappable{

	var descriptionField : String?
	var icon : String?
	var id : Int?
	var main : String?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable?{
		return Weather()
	}
	private override init(){
    }

	func mapping(map: Map)
	{
		descriptionField <- map["description"]
		icon <- map["icon"]
		id <- map["id"]
		main <- map["main"]
		
	}
}
