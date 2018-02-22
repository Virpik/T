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
    
    public var t_view: Ext_View {
        return Ext_View(origin: self)
    }
    
    public static var t_view: ExtStatic_View {
        return ExtStatic_View(origin: self)
    }
    
    public var _t_view: ExtDebug_View {
        return ExtDebug_View(origin: self)
    }
    
    public static var _t_view: ExtDebugStatic_View {
        return ExtDebugStatic_View(origin: self)
    }
}
