//
//  [UIView][T][Snapshot].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIView.Ext_View {
    public func snapshot() -> UIView {
        
        let view = UIImageView(frame: self.origin.bounds)
        view.image = self.render()
        
        return view
    }
    
    public func render() -> UIImage? {
        
        self.origin.layoutIfNeeded()
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(self.origin.frame.size, false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.origin.layer.render(in: context)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image
        }
        
        return nil
    }
}
