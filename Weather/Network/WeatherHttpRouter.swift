//
//  WeatherHttpRouter.swift
//  Weather
//
//  Created by TechFlitter on 2/11/17.
//  Copyright © 2017 Weather. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

enum WeatherHttpRouter: URLRequestConvertible {
    
    case weatherData(lat: Double, long: Double)

    var method: Alamofire.HTTPMethod {
        switch self {
        case .weatherData:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .weatherData(_, _):
            return "data/2.5/weather"
        }
    }
    
    var authorization: String? {
        switch self {
        case .weatherData:
            return nil
        }
    }
    
    var jsonArrayParameters: [Int64]? {
        switch self {
        default:
            return nil
        }
    }
    
    var jsonParameters: [String: Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var urlParameters: [String: Any]? {
        switch self {
        case .weatherData(let lat, let long):
            return ["lat": lat, "lon": long, "appid": weatherAPIKey]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = NSURL(string: Configuration.BaseURL())!
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path)!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.timeoutInterval = 60.0
        
        switch self {
        case .weatherData:
            return try URLEncoding.queryString.encode(urlRequest, with: self.urlParameters)
        }
    }
}
