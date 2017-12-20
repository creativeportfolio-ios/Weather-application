//
//	Coord.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Coord : NSObject, Mappable{

	var lat : Float?
	var lon : Float?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable?{
		return Coord()
	}
	private override init(){
    }

	func mapping(map: Map)
	{
		lat <- map["lat"]
		lon <- map["lon"]
		
	}
}
