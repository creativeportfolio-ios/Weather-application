//
//  NetworkManager.swift
//  Weather
//
//  Created by TechFlitter on 2/11/17.
//  Copyright © 2017 Weather. All rights reserved.
//

import Foundation

import BrightFutures
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

enum NetworkError: Error {
    case notFound
    case unauthorized
    case forbidden
    case nonRecoverable
    case unprocessableEntity(String?)
    case other
}

struct NetworkManager {
    
    static let networkQueue = DispatchQueue(label: "\(Bundle.main.bundleIdentifier ?? "com.techflitter").networking-queue", attributes: .concurrent)
    
    static func makeRequest<T: Mappable>(_ urlRequest: URLRequestConvertible) -> Future<T, NetworkError> {
        let promise = Promise<T, NetworkError>()
        let request = Alamofire.request(urlRequest)
            .validate()
            .responseObject(queue: networkQueue) { (response: DataResponse<T>)-> Void in
                print("\nResponse: \(NSString(data: response.data!, encoding: String.Encoding.utf8.rawValue)!)\n")
                switch response.result {
                case .success:
                    promise.success(response.result.value!)
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 403:
                    promise.failure(.forbidden)
                case .failure
                    where response.response?.statusCode == 404:
                    promise.failure(.notFound)
                case .failure
                    where response.response?.statusCode == 422:
                    var jsonData: String?
                    if let data = response.data {
                        jsonData = String(data: data, encoding: .utf8)
                    }
                    promise.failure(.unprocessableEntity(jsonData))
                case .failure
                    where response.response?.statusCode == 500:
                    promise.failure(.nonRecoverable)
                case .failure:
                    promise.failure(.other)
                }
        }
        
        print("\nRequest: ")
        debugPrint(request)
        print("\n")
        
        return promise.future
    }
    
    static func makeJSONObjectArrayRequest(_ urlRequest: URLRequestConvertible) -> Future<[NSDictionary], NetworkError> {
        let promise = Promise<[NSDictionary], NetworkError>()
        
        let request = Alamofire.request(urlRequest)
            .validate()
            .responseJSON(queue: networkQueue) { response in
                print(response.result)
                switch response.result {
                case .success(let JSON):
                    if let jsonObject = JSON as? [NSDictionary] {
                        promise.success(jsonObject)
                    }
                    else {
                        promise.failure(.other)
                    }
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 403:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 404:
                    promise.failure(.notFound)
                case .failure
                    where response.response?.statusCode == 500:
                    promise.failure(.nonRecoverable)
                case .failure:
                    promise.failure(.other)
                }
        }
        debugPrint(request)
        return promise.future
    }
    
    static func makeJSONStringArrayRequest(_ urlRequest: URLRequestConvertible) -> Future<[String], NetworkError> {
        let promise = Promise<[String], NetworkError>()
        
        let request = Alamofire.request(urlRequest)
            .validate()
            .responseJSON(queue: networkQueue) { response in
                switch response.result {
                case .success(let JSON):
                    if let jsonObject = JSON as? [String] {
                        promise.success(jsonObject)
                    } else {
                        promise.failure(.other)
                    }
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 403:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 404:
                    promise.failure(.notFound)
                case .failure
                    where response.response?.statusCode == 500:
                    promise.failure(.nonRecoverable)
                case .failure:
                    promise.failure(.other)
                }
        }
        
        debugPrint(request)
        
        return promise.future
    }
    
    static func Network
        (_ urlRequest: URLRequestConvertible) -> Future<[String: String], NetworkError> {
        let promise = Promise<[String: String], NetworkError>()
        
        let request = Alamofire.request(urlRequest)
            .validate()
            .responseJSON(queue: networkQueue) { response in
                switch response.result {
                case .success(let JSON):
                    if let jsonObject = JSON as? [String: String] {
                        promise.success(jsonObject)
                    } else {
                        promise.failure(.other)
                    }
                case .failure
                    where response.response?.statusCode == 401:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 403:
                    promise.failure(.unauthorized)
                case .failure
                    where response.response?.statusCode == 404:
                    promise.failure(.notFound)
                case .failure
                    where response.response?.statusCode == 500:
                    promise.failure(.nonRecoverable)
                case .failure:
                    promise.failure(.other)
                }
        }
        
        debugPrint(request)
        
        return promise.future
    }
}
