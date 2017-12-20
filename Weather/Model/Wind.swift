//
//	Wind.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Wind : NSObject, Mappable{

	var deg : Int?
	var speed : Float?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable?{
		return Wind()
	}
	private override init(){
    }

	func mapping(map: Map)
	{
		deg <- map["deg"]
		speed <- map["speed"]
		
	}

}
