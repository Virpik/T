//
//  [T][Styles][Shadow].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension T.Styles {
    public class Shadow: NSObject {
        
        public var color: UIColor = .clear
        
        public var radius: Float = 0
        
        public var opacity: Float = 1
        
        public var offset: CGSize = .zero
    }
}
