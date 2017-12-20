//
//  LocationService.swift
//  GuidedExplorers
//
//  Created by TechFlitter on 23/10/17.
//  Copyright © 2017 Urban Technology Systems. All rights reserved.
//

import Foundation
import CoreLocation
import Alamofire
import AlamofireObjectMapper

typealias responseBlock = (Bool, Any?) -> Void

let googleAPIKey = "AIzaSyDfAbqXNt_JgMl2MvO29WcMxF4td24jnJc"
let weatherAPIKey = "cfd903ccff8b9fda6fb0b7adda7e2b31"

extension Int {
    var degreesToRadians: Double { return Double(self) * .pi / 180 }
}
extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}

protocol LocationServiceDelegate {
    func tracingAuthorization(status: CLAuthorizationStatus)
    func tracingLocation(currentLocation: CLLocation)
    func tracingLocationDidFailWithError(error: NSError)
}

class LocationService: NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance: LocationService = {
        let instance = LocationService()
        return instance
    }()
    var locationManager: CLLocationManager?
    var currentLocation: CLLocation! = CLLocation()
    var delegate: LocationServiceDelegate?
    
    override init() {
        super.init()
    }
    
    func startLocationManager() {
        self.locationManager = CLLocationManager()
        guard let locationManager = self.locationManager else {
            return
        }
        locationManager.delegate = self
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.startUpdatingLocation()
    }
    
    // CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.currentLocation = location
        updateLocation(currentLocation: location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        updateLocationDidFailWithError(error: error as NSError)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingAuthorization(status: status)
    }
    
    // Private function
    private func updateLocation(currentLocation: CLLocation) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocation(currentLocation: currentLocation)
    }
    
    private func updateLocationDidFailWithError(error: NSError) {
        guard let delegate = self.delegate else {
            return
        }
        delegate.tracingLocationDidFailWithError(error: error)
    }
    
    //Get weather details
    func getWeatherService(lat: Double, long: Double, responseHandler: @escaping responseBlock) {
        NetworkManager.makeRequest(WeatherHttpRouter.weatherData(lat: lat, long: long))
            .onSuccess { (response: WeatherBase) in
                print(response)
                responseHandler(true, response)
            }
            .onFailure { error in
                responseHandler(false, error)
            }
            .onComplete { _ in
        }
    }
    
}
