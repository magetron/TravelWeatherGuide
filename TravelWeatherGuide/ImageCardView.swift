//
//  ImageCardView.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit
import Spring

class ImageCardView: DesignableImageView {
    
    var loading = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
    var smallImage = UIImageView()
    var hide = true
    var originalFrame = CGRectMake(0, 0, 0, 0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func setup(){
        self.userInteractionEnabled = true
        self.frame = CGRectMake(1000, 1000, 0, 0)
        self.layer.shadowOffset = CGSizeMake(0, 2)
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 0.3
        smallImage = UIImageView()
        smallImage.alpha = 0.6
        self.addSubview(smallImage)
        
        loading.hidesWhenStopped = true
    }
    
    func changeImage(img: UIImage, frame:CGRect){
        
        originalFrame = frame
        
        //var img = addFilter(img)
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.frame = frame
            self.smallImage.frame = CGRectMake(4, 4, img.size.width / 2, img.size.height / 2)
        })
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.smallImage.alpha = 0.3
            }) { (finish) -> Void in
                self.smallImage.image = img
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.smallImage.alpha = 0.6
                })
        }
        
        if hide{
            hide = false
            self.animation = "slideLeft"
            self.animate()
        }
    }
    
    func hideSelf(){
        
        if !hide {
            self.frame.origin = CGPointMake(self.frame.origin.x + self.frame.width * 1.5, self.frame.origin.y)
            hide = true
            self.animation = "slideLeft"
            self.animate()
        }
    }
    
    // movement  0 - 200
    func moveAccordingToDrag(movement:CGFloat){
        
        let movementConst: CGFloat = 200
        
        let centerX = originalFrame.origin.x + originalFrame.width / 2
        let centerY = originalFrame.origin.y + originalFrame.height / 2
        
        let totalCenterX = self.superview!.center.x - centerX
        let totalCenterY = self.superview!.center.y - centerY
        
        self.center = CGPointMake(centerX + totalCenterX * movement / movementConst, centerY + totalCenterY * movement / movementConst)
        
        let totalWidth = self.superview!.frame.width - originalFrame.width
        let totalHeight = self.superview!.frame.height - originalFrame.height
        
        self.frame.size = CGSizeMake(originalFrame.width + totalWidth * movement / movementConst, originalFrame.height + totalHeight * movement / movementConst)
        
        self.smallImage.alpha = 0.6 - movementConst / 20
    }
    
}
