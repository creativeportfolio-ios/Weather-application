//
//  WeatherViewController.swift
//  Weather
//
//  Created by TechFlitter on 02/11/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import GoogleMaps

class WeatherViewController: UIViewController {

    @IBOutlet weak var googleMapView: GMSMapView!
    
    var userMarker: GMSMarker!
    var currentLocation : CLLocation = CLLocation(latitude: 0, longitude: 0)
    var kDefaultZoomLevel = 15

    let overlayView: UIView = UIView()
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Map"
        
        LocationService.sharedInstance.startLocationManager()
        LocationService.sharedInstance.delegate = self
        googleMapView.delegate = self
        
        overlayView.backgroundColor = UIColor.lightGray
        overlayView.alpha = 0.3
        overlayView.frame = self.view.frame
        overlayView.isHidden = true
        self.view.addSubview(overlayView)
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.hidesWhenStopped = true
        self.view.addSubview(activityIndicator)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if CLLocationManager.locationServicesEnabled() {
            switch(CLLocationManager.authorizationStatus()) {
            case .restricted, .denied:
                self.showLocationPopUp()
            default:
                break
            }
        } else {
            self.showLocationPopUp()
            return
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func showLocationPopUp() {
        let alertController = UIAlertController (title: "Weather", message: "Enable location access from your iPhone settings.", preferredStyle: .alert)
        
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (_) -> Void in
            guard let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) else {
                return
            }
            
            if UIApplication.shared.canOpenURL(settingsUrl) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                } else {
                    let settingsURL = URL(string: UIApplicationOpenSettingsURLString)
                    UIApplication.shared.openURL(settingsURL!)
                }
            }
        }
        alertController.addAction(settingsAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func showActivityIndicatory(uiView: UIView) {
        
        activityIndicator.startAnimating()
    }
}

extension WeatherViewController : GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        self.getWeatherService(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        self.getWeatherService(lat: coordinate.latitude, long: coordinate.longitude)
    }
    
}

extension WeatherViewController : LocationServiceDelegate {
    
    func tracingAuthorization(status: CLAuthorizationStatus) {
        switch(status) {
        case .restricted, .denied:
            self.showLocationPopUp()
        default:
            break
        }
    }
    
    func tracingLocation(currentLocation: CLLocation) {
        self.currentLocation = currentLocation
        
        if (userMarker == nil) {
            userMarker = GMSMarker(position: (CLLocationCoordinate2D(latitude: Double(currentLocation.coordinate.latitude), longitude: Double(currentLocation.coordinate.longitude))))
            userMarker.icon = UIImage(named: "person")
            userMarker.map = googleMapView
            self.googleMapView.animate(to: GMSCameraPosition.camera(withLatitude: self.currentLocation.coordinate.latitude,
                                                                    longitude: self.currentLocation.coordinate.longitude,
                                                                    zoom: Float(self.kDefaultZoomLevel)))
        }
        
        self.userMarker.position = self.currentLocation.coordinate
    }
    
    func tracingLocationDidFailWithError(error: NSError) {
        
    }
}

extension WeatherViewController {
    func getWeatherService(lat: Double, long: Double) {
        overlayView.isHidden = false
        self.activityIndicator.startAnimating()
        LocationService.sharedInstance.getWeatherService(lat: lat, long: long) { (success, response) in
            self.overlayView.isHidden = true
            self.activityIndicator.stopAnimating()
            if (success) {
                let weatherDetailViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController")as? WeatherDetailViewController
                weatherDetailViewController?.weatherBase = response as! WeatherBase
                self.navigationController?.pushViewController(weatherDetailViewController!, animated: true)
            }
            else {
                let alertController = UIAlertController (title: "Weather", message: "Enable to fetch details from weather API", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
