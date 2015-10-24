//
//  ReturnButton.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit

class ReturnButton: UIButton {
    
    var outLine = CAShapeLayer()
    
    var parentController: ViewController!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.layer.shadowOffset = CGSizeMake(0, 2)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        
        self.addTarget(self, action: "dissAppear", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func appear(){
        
        outLine.path = drawPath().CGPath
        outLine.strokeColor = UIColor(red: 0.267, green: 0.608, blue: 0.600, alpha: 1.000).CGColor
        outLine.fillColor = UIColor.clearColor().CGColor
        outLine.lineWidth = 1.5
        outLine.lineCap = kCALineCapRound
        self.layer.addSublayer(outLine)
        
        var animateStrokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        animateStrokeEnd.duration = 2.0
        animateStrokeEnd.fromValue = 0.0
        animateStrokeEnd.toValue = 1.0
        animateStrokeEnd.delegate = self
        animateStrokeEnd.fillMode = kCAFillModeForwards
        animateStrokeEnd.removedOnCompletion = false
        outLine.addAnimation(animateStrokeEnd, forKey: "drawOutline")
        
    }
    
    func dissAppear(){
        outLine.removeAllAnimations()
        outLine.removeFromSuperlayer()
        parentController.clockButton.clockReturnNormalSize()
        parentController.mapView.changeIconWithTime()
        parentController.timeLine.disAppear()
    }
    
    override func animationDidStop(anim: CAAnimation!, finished flag: Bool) {
        if flag{
            if anim == outLine.animationForKey("drawOutline"){
                var animationFill = CABasicAnimation(keyPath: "fillColor")
                animationFill.duration = 2.0
                animationFill.fromValue = UIColor.clearColor().CGColor
                animationFill.toValue = UIColor(red: 0.267, green: 0.608, blue: 0.600, alpha: 0.4).CGColor
                outLine.fillColor = UIColor.clearColor().CGColor
                animationFill.delegate = self
                animationFill.fillMode = kCAFillModeForwards
                animationFill.removedOnCompletion = false
                outLine.addAnimation(animationFill, forKey: "fill")
            }
        }
    }
    
    
    func drawPath()->UIBezierPath{
        
        var polygonPath = UIBezierPath()
        polygonPath.moveToPoint(CGPointMake(bounds.minX + 0.52000 * bounds.width, bounds.minY + 0.18000 * bounds.height))
        polygonPath.addLineToPoint(CGPointMake(bounds.minX + 0.94000 * bounds.width, bounds.minY + 0.82000 * bounds.height))
        polygonPath.addLineToPoint(CGPointMake(bounds.minX + 0.08000 * bounds.width, bounds.minY + 0.82000 * bounds.height))
        polygonPath.addLineToPoint(CGPointMake(bounds.minX + 0.52000 * bounds.width, bounds.minY + 0.18000 * bounds.height))
        polygonPath.closePath()
        return polygonPath
    }
    
}
