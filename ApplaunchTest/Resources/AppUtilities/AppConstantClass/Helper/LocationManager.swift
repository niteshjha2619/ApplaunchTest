//
//  LocationManager.swift
//  NetworkManager
//
//  Created by Creative Kids on 07/08/21.
//

import Foundation
import CoreLocation
import UIKit

@objc protocol LocationManagerDelegate {
    @objc optional func didUserChangeLocation(_ location: CLLocation)
}

class LocationManager: UIResponder,CLLocationManagerDelegate {
    // MARK: - Properties
    var locationManager :CLLocationManager?
    var latitude        :Double?
    var longitude       :Double?
    var clLocation      : CLLocation?
    var manager = CLLocationManager()
    var delegate:LocationManagerDelegate?
    static let sharedInstance = LocationManager()
    
    override init() {
        super.init()
        self.locationSetup()
    }
    func locationSetup() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        // Request location authorization
        locationManager?.requestWhenInUseAuthorization()
        // self.authorizeUserLocation()
        locationManager?.startUpdatingLocation()
    }
    
    func authorizeUserLocation() {
        if manager.authorizationStatus != .authorizedWhenInUse {
            locationManager?.requestWhenInUseAuthorization()
        }
    }
    
    public func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()
        case .authorizedWhenInUse:
            manager.startUpdatingLocation()
        case .authorizedAlways:
            manager.startUpdatingLocation()
        case .restricted, .denied:
            break
        @unknown default:
            break;
        }
    }
    
    
    // MARK: - Location Manager Delegate Method
    public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        print("User Location Received == Latitude-> \(self.latitude ?? 0.0) , longitude -> \(self.longitude ?? 0)")
        UserDefaults.standard.setUserSelectedLocation(Double.getDouble(self.latitude), Double.getDouble(self.longitude))
        delegate?.didUserChangeLocation?(location)
        self.locationManager?.stopUpdatingLocation()
    }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error \(error.localizedDescription)")
    }
    
    // convert to coordinate to geocoder
    func geocoderLocation ( completionHandler:@escaping ([CLPlacemark]) -> Void) {
        if let location = self.locationManager?.location {
            let geoCoder = CLGeocoder()
            geoCoder.reverseGeocodeLocation(location) { (placemark, error) in
                if error == nil {
                    completionHandler(placemark!)
                }
            }
        }
    }
    
    //MARK:- To check user permisssion for location
    func hasLocationPermission() -> Bool {
        var hasPermission = false
        if CLLocationManager.locationServicesEnabled() {
            switch manager.authorizationStatus {
            case .notDetermined, .restricted, .denied:
                hasPermission = false
            case .authorizedAlways, .authorizedWhenInUse:
                hasPermission = true
            @unknown default:
                return false
            }
        } else {
            hasPermission = false
        }
        return hasPermission
    }
    
    //MARK:- Alert for enable location for partcular app
    func alertForLocationPermissionForApp(viewController:UIViewController){
        let alertController = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in app settings.", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Settings", style: .default) { action in
            //Redirect to Settings app
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl)  {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
                else  {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        })
        alertController.addAction(UIAlertAction(title: "Cancel", style: .default){  action in
            viewController.dismiss(animated: true, completion: nil)
        })
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    //MARK:- Alert for enable location for device
    func alertForEnableLocation (viewController:UIViewController) {
        let alert = UIAlertController(title: "Location Permission Required", message: "Please enable location permissions in settings.", preferredStyle: UIAlertController.Style.alert)
        // self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Settings", style: .default) { action in
            // If general location settings are disabled then open general location settings
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl)  {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                    })
                }
                else  {
                    UIApplication.shared.openURL(settingsUrl)
                }
            }
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default){
            action in
            viewController.dismiss(animated: true, completion: nil)
        })
        viewController.present(alert, animated: true, completion: nil)
    }
    
    //MARK get Location using geoCode
    func getAddressFromLatLon(pdblLatitude: Double, withLongitude pdblLongitude: Double, completion: @escaping ((String,[String:String])->())) {
        var center : CLLocationCoordinate2D = CLLocationCoordinate2D()
        let lat: Double = Double("\(pdblLatitude)")!
        
        let lon: Double = Double("\(pdblLongitude)")!
        var addressDict:[String:String] = ["subLocality":"","landmark":"","city":"","state":"","country":"","postalCode":""]
        let ceo: CLGeocoder = CLGeocoder()
        center.latitude = lat
        center.longitude = lon
        
        let loc: CLLocation = CLLocation(latitude:center.latitude, longitude: center.longitude)
        
        
        ceo.reverseGeocodeLocation(loc, completionHandler: {(placemarks, error) in
            if (error != nil)
            {
            }
            
            if placemarks != nil
            {
                let pm = placemarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    let pm = placemarks![0]
                    //                            print(pm.location)
                    //                            print(pm.country ?? "")
                    //                            print(pm.locality ?? "")
                    //                            print(pm.subLocality ?? "")
                    //                            print(pm.thoroughfare ?? "")
                    //                            print(pm.postalCode ?? "")
                    //                            print(pm.subThoroughfare ?? "")
                    //                            print(pm.subAdministrativeArea ?? "")
                    //                            print(pm.administrativeArea ?? "")
                    addressDict["subLocality"] = pm.subLocality ?? ""
                    addressDict["landmark"] = pm.thoroughfare ?? ""
                    addressDict["city"] = pm.locality ?? ""
                    addressDict["state"] = pm.administrativeArea ?? ""
                    addressDict["country"] = pm.country ?? ""
                    addressDict["postalCode"] = pm.postalCode ?? ""
                    
                    var addressString : String = ""
                    if pm.subLocality != nil {
                        addressString = addressString + pm.subLocality! + ", "
                    }
                    if pm.thoroughfare != nil {
                        addressString = addressString + pm.thoroughfare! + ", "
                    }
                    if pm.locality != nil {
                        addressString = addressString + pm.locality! + ", "
                    }
                    if pm.administrativeArea != nil{
                        addressString = addressString + pm.administrativeArea! + ", "
                        if pm.country != nil {
                            addressString = addressString + pm.country! + ", "
                        }
                    }
                    if pm.postalCode != nil {
                        addressString = addressString + pm.postalCode! + " "
                    }
                    print(addressString)
                    completion(addressString,addressDict)
                }
            }
        })
        
    }
}

