//
//  TView.swift
//  TSuppot
//
//  Created by Virpik on 28/12/2016.
//  Copyright © 2016 Sybis. All rights reserved.
//

import UIKit

public extension UIView {
    public convenience init(width: CGFloat, height: CGFloat) {
        let size = CGSize(width: width, height: height)
        self.init(size: size)
    }
    
    
    public convenience init(size: CGSize) {
        let frame = CGRect(origin: CGPoint.zero, size: size)
        self.init(frame: frame)
    }
    
    public static func default1x1() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 1, height: 1))
    }
    
    public static func default10x10() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
    
    public static func default20x20() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
    }
    
    public static func default50x50() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    public static func default100x100() -> Self {
        return self.init(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
    }
    
    public static func defaultScreen() -> Self {
        return self.init(frame: UIScreen.main.bounds)
    }
}

public extension UIView {
    
    func setup(fromXib name: String) {
        guard let view = self.load(fromNib: name) else {
            return
        }
        
        self.tAddSubview(view: view, isSetBounds: true)
    }
    
    func load(fromNib name: String) -> UIView? {
        let bundle = Bundle(for: self.classForCoder)
        let nib = UINib(nibName: name, bundle: bundle)
        
        let anyObj = nib.instantiate(withOwner: self, options: nil)[safe: 0]
        
        return anyObj as? UIView
    }
    
    /// if isBounds == true { view.frame = self.bounds }
    public func tAddSubview(view: UIView, isSetBounds: Bool = false, autoresizingMask: UIViewAutoresizing =  [.flexibleWidth, .flexibleHeight]) {
        
        if isSetBounds {
            view.frame = self.bounds
        }
        
        view.autoresizingMask = autoresizingMask
        self.addSubview(view)
    }
    
    public func tHidde(duration: TimeInterval, completion: Block? = nil) {
        let alpha = self.alpha
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0
        }) { (_) in
            self.isHidden = true
            self.alpha = alpha
            completion?()
        }
    }
    
    public func tShow(duration: TimeInterval, completion: Block? = nil) {
        let alpha = self.alpha
        
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.alpha = alpha
        }) { (_) in
            completion?()
        }
    }
    
    public func selfdestruction(isAnimation: Bool = true, after: TimeInterval = 1, handler: Block? = nil) {
        delay(after) {
            if !isAnimation {
                self.removeFromSuperview()
                handler?()
                return
            }
            
            self.tHidde(duration: 0.2) {
                self.removeFromSuperview()
                handler?()
            }
        }
    }
}

public extension UIView {
    public func snapshot() -> UIView {
        
        let view = UIImageView(frame: self.bounds)
        view.image = self.render()
        
        return view
    }
    
    public func render() -> UIImage? {
        
        self.layoutIfNeeded()
        
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, scale)
        
        if let context = UIGraphicsGetCurrentContext() {
            
            self.layer.render(in: context)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            
            return image
        }
        
        return nil
    }
    
    public func shake () {
        let midX = self.frame.midX
        let midY = self.frame.midY
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        
        animation.fromValue = CGPoint(x: midX - 10, y: midY)
        animation.toValue = CGPoint(x: midX + 10, y: midY)
        
        layer.add(animation, forKey: "position")
    }
}

public extension UIView {
    @IBInspectable public var tBRadius: Float {
        get {
            return self.layer.cornerRadius.float
        }
        
        set (value) {
            self.layer.cornerRadius = value.cgFloat
        }
    }
    
    @IBInspectable public var tBColor: UIColor? {
        get {
            
            if let cgColor = self.layer.borderColor {
                return UIColor(cgColor: cgColor)
            }
            
            return nil
        }
        
        set (value) {
            self.layer.borderColor = value?.cgColor
        }
    }
    
    @IBInspectable public var tBWidth: Float {
        get {
            return self.layer.borderWidth.float
        }
        
        set (value) {
            self.layer.borderWidth = value.cgFloat
        }
    }
}

public extension UIView {
    
    private static var _dissmissKeyboardGestures: [UIView: UITapGestureRecognizer] = [:]
    
    private var _isDissmissKeyboardTag: Int {
        return 989
    }
    
    public var isDissmissKeyboard: Bool {
        get {
            return UIView._dissmissKeyboardGestures[self] != nil
        }
        
        set (value) {
            
            if !value {
                if let gesture = UIView._dissmissKeyboardGestures[self] {
                    self.removeGestureRecognizer(gesture)
                }
                
                return
            }
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self._keyboardDissmiss(sender:)))
            gesture.cancelsTouchesInView = false
            self.addGestureRecognizer(gesture)
            UIView._dissmissKeyboardGestures[self] = gesture
            
        }
    }
    
    @objc private func _keyboardDissmiss(sender: NSObject) {
        print(self.classForCoder, sender.classForCoder, #function)
        self.endEditing(false)
    }
}
