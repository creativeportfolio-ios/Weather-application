//
//	Sy.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Sy : NSObject, Mappable{

	var country : String?
	var message : Float?
	var sunrise : Int?
	var sunset : Int?

    required init?(map: Map) {
        
    }
    
	class func newInstance(map: Map) -> Mappable?{
		return Sy()
	}
	private override init(){
    }

	func mapping(map: Map)
	{
		country <- map["country"]
		message <- map["message"]
		sunrise <- map["sunrise"]
		sunset <- map["sunset"]
		
	}
}
