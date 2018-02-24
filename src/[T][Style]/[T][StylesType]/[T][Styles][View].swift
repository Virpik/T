//
//  [T][Styles][View].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension T.Styles {
    public struct View {
        
        public var bgColor: UIColor?
        
        public var alpha: CGFloat = 1
        
        public var bordeWidth: Float = 0
        
        public var cornerRadius: Float = 0
        
        public var borderColor: UIColor = UIColor.black
        
        public var tintColor: UIColor?
        
        public var shadow: Shadow?
        
        public init() {
            
        }
    }
}
