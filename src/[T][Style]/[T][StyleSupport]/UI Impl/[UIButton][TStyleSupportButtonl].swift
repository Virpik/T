//
//  [UIButton][TStyleSupportButtonl].swift
//  T
//
//  Created by Virpik on 16/03/2018.
//

import Foundation

extension UIButton: TStyleSupportButton {
    public var aLabel: TStyleSupportLabel {
        return self
    }
    
    public var aView: TStyleSupportView {
        return self
    }
}
