//
//  WeatherDataQTree.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit

class WeatherDataQTree: NSObject, QTreeInsertable{
    
    var coordinate: CLLocationCoordinate2D
    
    var cityID = ""
    
    init(position: CLLocationCoordinate2D, cityID: String) {
        coordinate = position
        self.cityID = cityID
        super.init()
    }
    
    func archive()->NSDictionary{
        var dict = NSMutableDictionary()
        dict.setObject(cityID, forKey: "cityID")
        dict.setObject(NSNumber(double: coordinate.latitude), forKey: "latitude")
        dict.setObject(NSNumber(double: coordinate.longitude), forKey: "longitude")
        return dict
    }
    
}
