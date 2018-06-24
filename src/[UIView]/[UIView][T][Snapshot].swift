//
//  [UIView][T][Snapshot].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIView {
    public func snapshot() -> UIView {
        
        let view = UIImageView(frame: self.bounds)
        view.image = self.render()
        
        return view
    }
    
    public func render() -> UIImage? {
        
        self.layoutIfNeeded()
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.layer.render(in: context)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image
        }
        
        return nil
    }
}
