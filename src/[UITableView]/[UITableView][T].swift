//
//  [UITableView].swift
//  Pods-TDemo
//
//  Created by Virpik on 02/02/2018.
//

import Foundation

extension UITableView {
    public typealias TypeObject = UITableView

    public struct Ext {
        public var origin: TypeObject
    }

    public struct ExtStatic {
        public var origin: TypeObject.Type
    }

    public var t: Ext {
        return Ext(origin: self)
    }

    public static var t: ExtStatic {
        return ExtStatic(origin: self)
    }
}

