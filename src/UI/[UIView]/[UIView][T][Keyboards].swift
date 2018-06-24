//
//  [UIView][T][Keyboards].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIView {
    
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
}

extension UIView {
    @objc fileprivate func _keyboardDissmiss(sender: NSObject) {
        tLog(self.classForCoder, sender.classForCoder, #function)
        self.endEditing(false)
    }
}
