//
//	Main.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Main : NSObject, Mappable {

	var grndLevel : Float?
	var humidity : Int?
	var pressure : Float?
	var seaLevel : Float?
	var temp : Float?
	var tempMax : Float?
	var tempMin : Float?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable? {
		return Main()
	}
    
	private override init() {
    }

	func mapping(map: Map) {
		grndLevel <- map["grnd_level"]
		humidity <- map["humidity"]
		pressure <- map["pressure"]
		seaLevel <- map["sea_level"]
		temp <- map["temp"]
		tempMax <- map["temp_max"]
		tempMin <- map["temp_min"]
		
	}
}
