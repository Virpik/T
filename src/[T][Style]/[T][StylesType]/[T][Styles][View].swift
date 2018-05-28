//
//  [T][Styles][View].swift
//  T
//
//  Created by Virpik on 24/02/2018.
//

import Foundation

extension T.Styles {
    public struct View: Configurable, Transformable, THashable {
        
        public var bgColor: UIColor?
        
        public var alpha: CGFloat = 1
        
        public var bordeWidth: Float = 0
        
        public var cornerRadius: Float = 0
        
        public var borderColor: UIColor = UIColor.black
        
        public var tintColor: UIColor?
        
        public var shadow: Shadow?
        
        public var hashes: [Int] {
            return [
                self.bgColor?.hashValue ?? 0,
                self.alpha.hashValue,
                self.bordeWidth.hashValue,
                self.cornerRadius.hashValue,
                self.borderColor.hashValue,
                self.tintColor?.hashValue ?? 0,
                self.shadow?.hashValue ?? 0
            ]
        }
        
        public init() {
            
        }
    }
}
