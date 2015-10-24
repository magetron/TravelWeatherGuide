//
//  ImageCache.swift
//  TravelWeatherGuide
//
//  Created by iD Student on 7/28/15.
//  Copyright (c) 2015 Patrick.Inc. All rights reserved.
//

import Foundation
import UIKit
import Haneke

@objc protocol ImageCacheDelegate: class {
    optional func gotImageFromCache(image: UIImage, cityID: String)
    optional func gotSmallImageFromCache(image: UIImage, cityID: String)
}

class ImageCache: NSObject {
    
    static var smallImagesUrl = [String: String]()
    static var imagesUrl = [String: String]()
    
    var delegate: ImageCacheDelegate!
    
    func getSmallImageFromCache(url: String, cityID: String){
        // get the image from cache
        let cache = Shared.dataCache
        var img = UIImage()
        cache.fetch(URL: NSURL(string: url)!).onSuccess { image in
            img = UIImage(data: image)!
            self.delegate?.gotSmallImageFromCache!(img, cityID: cityID)
        }
    }
    
    func getImageFromCache(url: String, cityID: String){
        
        // get the image from cache
        let cache = Shared.dataCache
        var img = UIImage()
        cache.fetch(URL: NSURL(string: url)!).onSuccess { image in
            img = UIImage(data: image)!
            self.delegate?.gotImageFromCache!(img, cityID: cityID)
        }
    }
    
}
