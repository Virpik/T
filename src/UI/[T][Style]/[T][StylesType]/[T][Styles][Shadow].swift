//
//  [T][Styles][Shadow].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension T.Styles {
    
    public final class Shadow: NSObject, Configurable, Transformable {
        
        public var color: UIColor = .clear
        
        public var radius: Float = 0
        
        public var opacity: Float = 1
        
        public var offset: CGSize = .zero
        
        public func set(_ block: ((inout Shadow) -> Void)) -> Shadow {
            
            var shadow = Shadow()
            
            shadow.color = self.color
            shadow.radius = self.radius
            shadow.opacity = self.opacity
            shadow.offset = self.offset
            
            block(&shadow)
            
            return shadow
        }
    }
}
