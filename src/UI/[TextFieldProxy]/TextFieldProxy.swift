//
//  TextFieldProxy.swift
//  T
//
//  Created by Virpik on 10/04/2018.
//

import Foundation

public class TextFieldProxy: NSObject, UITextFieldDelegate {
    
    public var handlerNotificationDidBeginEditing: Block?
    public var handlerNotificationDidEndEditing: Block?
    public var handlerNotificationDidChange: Block?
    
    public var handlerDidEndEditing: Block?
    public var handlerDidBeginEditing: Block?
    
//    @available(iOS 10.0, *)
//    var handlerDidEndEditing: ((UITextFieldDidEndEditingReason) -> Void)?
    
    public var handlerShouldClear: (() -> Bool)?
    public var handlerShouldReturn: (() -> Bool)?
    public var handlerShouldEndEditing: (() -> Bool)?
    public var handlerShouldBeginEditing: (() -> Bool)?
    public var handlerShouldChangeCharacters: ((NSRange, String) -> Bool)?

    let textField: UITextField
    
    public init(textField: UITextField) {
        self.textField = textField
        
        super.init()
        
        self.textField.delegate = self
        
        let nc = NotificationCenter.default
        
        nc.addObserver(forName: UITextField.textDidBeginEditingNotification, object: self.textField, queue: .main) { (n) in
            self.handlerNotificationDidBeginEditing?()
        }
        
        nc.addObserver(forName: UITextField.textDidEndEditingNotification, object: self.textField, queue: .main) { (n) in
            self.handlerNotificationDidEndEditing?()
        }
        
        nc.addObserver(forName: UITextField.textDidChangeNotification, object: self.textField, queue: .main) { (n) in
            self.handlerNotificationDidChange?()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.handlerDidEndEditing?()
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        self.handlerDidBeginEditing?()
    }

//    @available(iOS 10.0, *)
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
//        self.handlerDidEndEditing?(reason)
//    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return self.handlerShouldClear?() ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return self.handlerShouldReturn?() ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return self.handlerShouldEndEditing?() ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return self.handlerShouldBeginEditing?() ?? true
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.handlerShouldChangeCharacters?(range, string) ?? true
    }
}
