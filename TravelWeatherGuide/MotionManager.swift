//
//  MotionManager.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreMotion

@objc protocol MotionManagerDelegate: NSObjectProtocol{
    optional func gotAttitudeRoll(roll: CGFloat)
}

var UserMotion: MotionManager = MotionManager()

class MotionManager: NSObject{
    
    var manager = CMMotionManager()
    var delegate: MotionManagerDelegate?
    
    func start(){
        if manager.gyroAvailable {
            manager.gyroUpdateInterval = 0.4
            let queue = NSOperationQueue.mainQueue
            manager.startDeviceMotionUpdatesUsingReferenceFrame(CMAttitudeReferenceFrame.XArbitraryCorrectedZVertical, toQueue: queue(), withHandler: { (data, error) -> Void in
                self.delegate?.gotAttitudeRoll!(CGFloat((data as CMDeviceMotion).attitude.roll))
            })
        }
    }
    
    func stop(){
        manager.stopDeviceMotionUpdates()
    }
    
}
