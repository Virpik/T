//
//  UIAnimate.swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public func UIAnimate(withDuration duration: TimeInterval, animations: @escaping Block, completion: ((Bool) -> Void)?) {
    UIView.animate(withDuration: duration, animations: animations, completion: completion)
}
