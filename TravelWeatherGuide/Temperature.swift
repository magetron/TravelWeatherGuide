//
//  Temperature.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation

enum TUnit {
    case Celcius
    case Fahrenheit
}

extension TUnit {
       
    var stringValue: String {
        switch self {
        case .Celcius:
            return "C"
        case .Fahrenheit:
            return "F"
        }
    }
    
    // True if and only if Fahrenheit
    var boolValue: Bool {
        return self == .Fahrenheit
    }
    
    func format(var temperature: Int) -> String {
        if self == .Fahrenheit {
            temperature = WeatherMapCalculations.degreeToF(temperature)
        }
        return "\(temperature)°\(self.stringValue)"
    }
    
    var inverse: TUnit {
        switch self {
        case .Celcius:
            return .Fahrenheit
        case .Fahrenheit:
            return .Celcius
        }
    }
    
}
