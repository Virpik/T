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
        return UIImagePNGRepresentation(self)
    }
    
    var jpg: Data? {
        return UIImageJPEGRepresentation(self, 0)
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
}
