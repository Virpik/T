//
//  CustomPlaceholderTextField.swift
//  Hero
//
//  Created by Virpik on 05/07/2018.
//

import Foundation

public class CustomPlaceholderTextField: UITextField {
    
    override public var text: String? {
        get {
            return super.text//self.labelPlaceHolder.text
        }
        
        set(value) {
            
            if value?.count ?? 0 > 0 {
                self.hidePlaceholder()
            } else {
                self.showPlaceHolder()
            }
            
            super.text = value
        }
    }
    
    override public var placeholder: String? {
        
        get {
            return self.labelPlaceHolder.text
        }
        
        set(value) {
            self.labelPlaceHolder.text = value
        }
    }
    
    override public var attributedPlaceholder: NSAttributedString? {
        
        get {
            return self.labelPlaceHolder.attributedText
        }
        
        set(value) {
            self.self.labelPlaceHolder.attributedText = value
        }
    }
    
    public var placeHolderLayout: ((UILabel) -> ())?
    
    var labelPlaceHolder = UILabel()
    
    var proxy: TextFieldProxy?
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        self._init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self._init()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self._init()
    }
    
    func _init() {
        self.addSubview(self.labelPlaceHolder)
        self.labelPlaceHolder.isUserInteractionEnabled = false
        
        self.proxy = TextFieldProxy(textField: self)
        
        self.proxy?.handlerNotificationDidBeginEditing = {
            self.hidePlaceholder()
        }
        
        self.proxy?.handlerNotificationDidEndEditing = {
            if self.text?.count ?? 0 == 0 {
                self.showPlaceHolder()
            }
        }
        
        self.proxy?.handlerNotificationDidChange = {
            
        }
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        
        if let layout = self.placeHolderLayout {
            layout(self.labelPlaceHolder)
            return
        }
        
        self.labelPlaceHolder.frame = self.bounds
    }
    
    func showPlaceHolder() {
        self.labelPlaceHolder.isHidden = false
    }
    
    func hidePlaceholder() {
        self.labelPlaceHolder.isHidden = true
    }
    
    @discardableResult
    public func apply(_ style: UITextFieldStyle?) -> CustomPlaceholderTextField {
        self.apply(style?.view)
        self.apply(style?.label)
        self.labelPlaceHolder.apply(style?.placeholder)
        
        return self
    }
}
