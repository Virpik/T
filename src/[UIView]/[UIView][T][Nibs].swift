//
//  [UIView][T][Nibs].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIView.Ext_View {
    @discardableResult
    public func setup<T: UIView>() -> T? {
        
        let nibName = String(describing: type(of: self.origin))
        
        guard let view: T = self.load(fromNib: nibName) else {
            return nil
        }
        
        self.addSubview(view: view, isSetBounds: true)
        return view
    }
    
    @discardableResult
    public func load<T: UIView>(fromNib name: String) -> T? {
        let _class = type(of: self.origin)
        
        let bundle = Bundle(for: _class)
        let nib = UINib(nibName: name, bundle: bundle)
        let anyObj = nib.instantiate(withOwner: self.origin, options: nil)[safe: 0]
        
        return anyObj as? T
    }
    
    
    public func setup(fromXib name: String) {
        guard let view = self.load(fromNib: name) else {
            return
        }
        
        self.addSubview(view: view, isSetBounds: true)
    }
    
    public func load(fromNib name: String) -> UIView? {
        let bundle = Bundle(for: self.origin.classForCoder)
        let nib = UINib(nibName: name, bundle: bundle)
        
        let anyObj = nib.instantiate(withOwner: self.origin, options: nil)[safe: 0]
        
        return anyObj as? UIView
    }
    
    /// if isBounds == true { view.frame = self.bounds }
    public func addSubview(view: UIView, isSetBounds: Bool = false, autoresizingMask: UIViewAutoresizing =  [.flexibleWidth, .flexibleHeight]) {
        
        if isSetBounds {
            view.frame = self.origin.bounds
        }
        
        view.autoresizingMask = autoresizingMask
        self.origin.addSubview(view)
    }
}
