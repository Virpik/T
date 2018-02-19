//
//  [TView][T].swift
//  Pods-TDemo
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIView {
    public typealias TypeObject_UIView = UIView
    
    public struct Ext_View {
        public var origin: TypeObject_UIView
    }
    
    public struct ExtStatic_View {
        public var origin: TypeObject_UIView.Type
    }
    
    public struct ExtDebug_View {
        public var origin: TypeObject_UIView
    }
    
    public struct ExtDebugStatic_View {
        public var origin: TypeObject_UIView.Type
    }
    
    public var ext_view: Ext_View {
        return Ext_View(origin: self)
    }
    
    public static var ext_view: ExtStatic_View {
        return ExtStatic_View(origin: self)
    }
    
    public var _ext_view: ExtDebug_View {
        return ExtDebug_View(origin: self)
    }
    
    public static var _ext_view: ExtDebugStatic_View {
        return ExtDebugStatic_View(origin: self)
    }
}
