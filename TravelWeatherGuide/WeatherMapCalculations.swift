//
//  WeatherMapCalculations.swift
//  
//
//  Created by iD Student on 7/28/15.
//
//

import Foundation
import UIKit

class WeatherMapCalculations: NSObject {
    
    // Convert Kelvin/Celcius temperature to another unit
    class func kelvinConvert(var degree: Double!, unit: TUnit) -> Int {
        // Workaround for OpenWeatherMap API bug:
        // sometimes temperature is returned in Celcius directly
        if degree > 200 {
            degree = degree - 273.15
        }
        if unit == TUnit.Fahrenheit {
            degree = degreeToF(degree)
        }
        return Int(round(degree))
    }
    
    class func kelvinConvert(degree: Int!, unit: TUnit) -> Int {
        return kelvinConvert(Double(degree), unit: unit)
    }
    
    class func degreeToF(var degree: Double) -> Double {
        return degree * 1.8 + 32
    }
    
    class func degreeToF(degree: Int) -> Int {
        return Int(round(degreeToF(Double(degree))))
    }
    
    // get the diagonal real distance of the map displayed on the screen
    class func getTheDistanceBased(region: GMSVisibleRegion) -> Double{
        let location = CLLocation(latitude: region.farLeft.latitude, longitude: region.farLeft.longitude)
        return location.distanceFromLocation(CLLocation(latitude: region.nearRight.latitude, longitude: region.nearRight.longitude))
    }
    
    // correctly display the distance with text
    class func displayKMWithLabel(kilometer: Double) -> String{
        
        if kilometer >= 1{
            var km = Int(kilometer)
            if km > 100 && km <= 1000 {
                km = km / 10
                km = km * 10
            }else if km > 1000 && km <= 10000 {
                km = km / 10
                km = km * 10
            }
            return "\(km) km"
            
        }else{
            var m = Int(kilometer * 1000)
            if m > 100 {
                m = m / 10
                m = m * 10
            }
            
            return "\(m) m"
            
        }
        
    }
 
    class func getDestinationPointWithDistanceAndLongitudeAndLatitude(centerLocation:CLLocationCoordinate2D, distanceX: Double, distanceY: Double)->CLLocationCoordinate2D{
        let constant = 0.1
        
        var locationYdegree = centerLocation.latitude
        if locationYdegree > 0{
            locationYdegree = locationYdegree - constant
        }else{
            locationYdegree = locationYdegree + constant
        }
        
        var locationXdegree = centerLocation.longitude
        if locationXdegree > 0{
            locationXdegree = locationXdegree - constant
        }else{
            locationXdegree = locationXdegree + constant
        }
        
        let currlocation = CLLocation(latitude: centerLocation.latitude, longitude: centerLocation.longitude)
        
        let xRatio = currlocation.distanceFromLocation(CLLocation(latitude: centerLocation.latitude, longitude: locationXdegree)) / 1000
        let yRatio = currlocation.distanceFromLocation(CLLocation(latitude: locationYdegree, longitude: centerLocation.longitude)) / 1000
        
        let x = distanceX * constant / xRatio + centerLocation.longitude
        let y = distanceY * constant / yRatio + centerLocation.latitude
        return CLLocationCoordinate2D(latitude: y, longitude: x)
        
    }
    
    // Convert distance and center or MKCoordinateRegion
    class func convertRegion(center: CLLocationCoordinate2D, distance: Double)->MKCoordinateRegion{
        var northWestPoint = WeatherMapCalculations.getDestinationPointWithDistanceAndBearing(distance, coordinate: center, bearing: 315)
        var southEastPoint = WeatherMapCalculations.getDestinationPointWithDistanceAndBearing(distance, coordinate: center, bearing: 135)
        var lat = abs(northWestPoint.latitude - southEastPoint.latitude)
        var lon = abs(northWestPoint.longitude - southEastPoint.longitude)
        if lat > 360{
            lat = lat - 360
        }
        var span = MKCoordinateSpanMake(lat ,lon)
        return MKCoordinateRegionMake(center, span)
    }
    
    class func getDestinationPointWithDistanceAndBearing(distance: Double, coordinate: CLLocationCoordinate2D, bearing: CLLocationDirection)->CLLocationCoordinate2D{
        
        let constant = 0.1
        
        var locationXdegree = coordinate.longitude
        if locationXdegree > 0{
            locationXdegree = locationXdegree - constant
        }else{
            locationXdegree = locationXdegree + constant
        }
        
        var locationYdegree = coordinate.latitude
        if locationYdegree > 0{
            locationYdegree = locationYdegree - constant
        }else{
            locationYdegree = locationYdegree + constant
        }
        
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        
        let yRatio = location.distanceFromLocation(CLLocation(latitude: locationYdegree, longitude: coordinate.longitude))
        let xRatio = location.distanceFromLocation(CLLocation(latitude: coordinate.latitude, longitude: locationXdegree))
        
        // positive east, negative west
        let xAcceleration = sin(bearing * M_PI / 180) * distance
        //positive north,  negative south
        let yAcceleration = cos(bearing * M_PI / 180) * distance
        
        //distance travel in xy coordinates
        let x = xAcceleration * constant / xRatio
        let y = yAcceleration * constant / yRatio
        
        let arrivingYCoordinate = coordinate.latitude + y
        let arrivingXCoordinate = coordinate.longitude + x
        
        return CLLocationCoordinate2D(latitude: arrivingYCoordinate, longitude: arrivingXCoordinate)
        
    }
    
    
}
