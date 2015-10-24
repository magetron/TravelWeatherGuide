//
//  LocationManager.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import UIKit

@objc protocol LocationManagerDelegate: NSObjectProtocol{
    optional func gotCurrentLocation(location: CLLocation)
}

var UserLocation: LocationManager = LocationManager()

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    var delegate:LocationManagerDelegate?
    
    var centerLocation:CLLocation!
    
    var locationM:CLLocationManager = CLLocationManager()
    
    func setup(){
        // start updating location
        self.locationM.delegate = self
        self.locationM.desiredAccuracy = kCLLocationAccuracyBest
        self.locationM.requestAlwaysAuthorization()
        self.locationM.startUpdatingLocation()
    }
    
    //called when location update
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        centerLocation = locations[locations.count - 1] as! CLLocation
        
        self.delegate?.gotCurrentLocation!(centerLocation)
        
    }
    
}
