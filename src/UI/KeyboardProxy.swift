//
//  KeyboardProxy.swift
//  T
//
//  Created by Virpik on 11/04/2018.
//

import Foundation

public class KeyboardProxy: NSObject {
    
    public struct Keyboard {
        
        public var userInfo: [AnyHashable: Any]
        public var frameBegin: CGRect
        public var frameEnd: CGRect
        public var animationDuration: TimeInterval
        public var animationCurve: UIView.AnimationCurve?
        
        @available(iOS 9.0, *)
        public var isLocalUser: Bool {
            return _isLocalUser
        }
        
        private var _isLocalUser: Bool = false
        
        public init?(userInfo: [AnyHashable: Any]) {
            
            guard let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval else {
             
                return nil
            }
            
            guard let frameBegin = userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as? CGRect else {
                
                return nil
            }
            
            guard let frameEnd = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                
                return nil
            }
            
            let animationCurve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UIView.AnimationCurve
            
            if #available(iOS 9.0, *) {
                guard let isLocalUser = userInfo[UIResponder.keyboardIsLocalUserInfoKey] as? Bool else {
                    
                    return nil
                }
                
                self._isLocalUser = isLocalUser
            }
            
            self.userInfo = userInfo
            
            self.animationDuration = duration
            self.frameEnd = frameEnd
            self.frameBegin = frameBegin
            self.animationCurve = animationCurve
        }
    }

    public var handlerWillShow: BlockItem<Keyboard>?
    public var handlerDidShow: BlockItem<Keyboard>?
    public var handlerWillHide: BlockItem<Keyboard>?
    public var handlerDidHide: BlockItem<Keyboard>?
    
    public var handlerWillChangeFrame: BlockItem<Keyboard>?
    public var handlerDidChangeFrame: BlockItem<Keyboard>?
    
    public override init () {
        super.init()
        
        func getKeyboard(_ n: Notification) -> Keyboard? {
            guard let userInfo = n.userInfo else {
                return nil
            }
            
            return Keyboard(userInfo: userInfo)
        }
        
        let nc = NotificationCenter.default
        
        /// Will Show
        nc.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillShow?(keyboard)
        })
    
        /// Did Show
        nc.addObserver(forName: UIResponder.keyboardDidShowNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidShow?(keyboard)
        })
    
        /// Will Hide
        nc.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillHide?(keyboard)
        })
        
        /// Did Hide
        nc.addObserver(forName: UIResponder.keyboardDidHideNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidHide?(keyboard)
        })
        
        /// Will Change Frame
        nc.addObserver(forName: UIResponder.keyboardWillChangeFrameNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillChangeFrame?(keyboard)
        })
        
        /// Did Change Frame
        nc.addObserver(forName: UIResponder.keyboardDidChangeFrameNotification, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidChangeFrame?(keyboard)
        })
    }
    
    deinit {
        
    }
}
