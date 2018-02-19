//
//  [UIView][T][Nibs].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

public extension UIView.Ext_View {
    public func setup(fromXib name: String) {
        guard let view = self.load(fromNib: name) else {
            return
        }
        
        self.tAddSubview(view: view, isSetBounds: true)
    }
    
    public func load(fromNib name: String) -> UIView? {
        let bundle = Bundle(for: self.origin.classForCoder)
        let nib = UINib(nibName: name, bundle: bundle)
        
        let anyObj = nib.instantiate(withOwner: self, options: nil)[safe: 0]
        
        return anyObj as? UIView
    }
    
    /// if isBounds == true { view.frame = self.bounds }
    public func tAddSubview(view: UIView, isSetBounds: Bool = false, autoresizingMask: UIViewAutoresizing =  [.flexibleWidth, .flexibleHeight]) {
        
        if isSetBounds {
            view.frame = self.origin.bounds
        }
        
        view.autoresizingMask = autoresizingMask
        self.origin.addSubview(view)
    }
}
