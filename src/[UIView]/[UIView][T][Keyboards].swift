//
//  [UIView][T][Keyboards].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//

import Foundation

extension UIView.Ext_View {
    
    private static var _dissmissKeyboardGestures: [UIView: UITapGestureRecognizer] = [:]
    
    private var _isDissmissKeyboardTag: Int {
        return 989
    }
    
    public var isDissmissKeyboard: Bool {
        get {
            return UIView.Ext_View._dissmissKeyboardGestures[self.origin] != nil
        }
        
        set (value) {
            
            if !value {
                if let gesture = UIView.Ext_View._dissmissKeyboardGestures[self.origin] {
                    self.origin.removeGestureRecognizer(gesture)
                }
                
                return
            }
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(self.origin._keyboardDissmiss(sender:)))
            gesture.cancelsTouchesInView = false
            self.origin.addGestureRecognizer(gesture)
            UIView.Ext_View._dissmissKeyboardGestures[self.origin] = gesture
            
        }
    }
}

extension UIView {
    @objc fileprivate func _keyboardDissmiss(sender: NSObject) {
        print(self.classForCoder, sender.classForCoder, #function)
        self.endEditing(false)
    }
}
