//
//	RootClass.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class WeatherBase : NSObject, Mappable {

	var base : String?
	var clouds : Cloud?
	var cod : Int?
	var coord : Coord?
	var dt : Int?
	var id : Int?
	var main : Main?
	var name : String?
	var sys : Sy?
	var weather : [Weather]?
	var wind : Wind?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable? {
		return WeatherBase()
	}
    
	private override init() {
        
    }

	func mapping(map: Map) {
		base <- map["base"]
		clouds <- map["clouds"]
		cod <- map["cod"]
		coord <- map["coord"]
		dt <- map["dt"]
		id <- map["id"]
		main <- map["main"]
		name <- map["name"]
		sys <- map["sys"]
		weather <- map["weather"]
		wind <- map["wind"]
	}

}
