//
//	Cloud.swift
//	Model file Generated using: 
//	Vin.Favara's JSONExportV https://github.com/vivi7/JSONExport 
//	(forked from Ahmed-Ali's JSONExport)
//

import Foundation
import ObjectMapper

class Cloud : NSObject, Mappable{

	var all : Int?


	class func newInstance(map: Map) -> Mappable?{
		return Cloud()
	}
    
    required init?(map: Map) {
        
    }
    
	private override init(){
    }

	func mapping(map: Map)
	{
		all <- map["all"]
		
	}

}
