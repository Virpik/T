//
//  TImage.swift
//  TDemo
//
//  Created by Virpik on 26/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation
import UIKit

public extension UIImage {
    
    var png: Data? {
        return self.pngData()
    }
    
    var jpg: Data? {
        return self.jpegData(compressionQuality: 0)
    }
    
    public static var defaultColor: UIColor {
        return UIColor.red
    }
    
    public convenience init(color: UIColor, size: CGSize) {
        
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        color.setFill()
        
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        self.init(cgImage: image!.cgImage!)
    }
    
    public static func image1x1(color: UIColor?) -> UIImage {
        
        let color = color ?? self.defaultColor
        
        let size = CGSize(width: 1, height: 1)
        
        let image = UIImage(color: color, size: size)
        
        return image
    }
    
    public static func image10x10(color: UIColor?) -> UIImage {
        let color = color ?? self.defaultColor
        
        let size = CGSize(width: 10, height: 10)
        
        let image = UIImage(color: color, size: size)
        
        return image
    }

    public static func image20x20(color: UIColor?) -> UIImage {
        let color = color ?? self.defaultColor
        
        let size = CGSize(width: 20, height: 20)
        
        let image = UIImage(color: color, size: size)
        
        return image
    }

    public static func image50x50(color: UIColor?) -> UIImage {
        let color = color ?? self.defaultColor
        
        let size = CGSize(width: 50, height: 50)
        
        let image = UIImage(color: color, size: size)
        
        return image
    }

    public static func image100x100(color: UIColor?) -> UIImage {
        let color = color ?? self.defaultColor
        
        let size = CGSize(width: 100, height: 100)
        
        let image = UIImage(color: color, size: size)
        
        return image
    }

    public static func imageBoundsScreen(color: UIColor?) -> UIImage {
        let color = color ?? self.defaultColor
        
        let size = UIScreen.main.bounds.size
        
        let image = UIImage(color: color, size: size)
        
        return image
    }
    
    //https://stackoverflow.com/questions/31314412/how-to-resize-image-in-swift
    public func resize(size: CGSize) -> UIImage {
        let image = self
        let targetSize = size
        
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
}
