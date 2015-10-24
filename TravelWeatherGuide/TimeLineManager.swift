//
//  TimeLineManager.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit

@objc protocol TimeLineManagerDelegate: class {
    optional func progressUpdated(progress: Double)
}

class TimeLineManager: NSObject, InternetConnectionDelegate {
      
}
