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
        public var animationCurve: UIViewAnimationCurve?
        
        @available(iOS 9.0, *)
        public var isLocalUser: Bool {
            return _isLocalUser
        }
        
        private var _isLocalUser: Bool = false
        
        public init?(userInfo: [AnyHashable: Any]) {
            
            guard let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as? TimeInterval else {
                
                return nil
            }
            
            guard let frameBegin = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect else {
                
                return nil
            }
            
            guard let frameEnd = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect else {
                
                return nil
            }
            
            let animationCurve = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? UIViewAnimationCurve
            
            if #available(iOS 9.0, *) {
                guard let isLocalUser = userInfo[UIKeyboardIsLocalUserInfoKey] as? Bool else {
                    
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

    public var handlerWillShow: BlockForItem<Keyboard>?
    public var handlerDidShow: BlockForItem<Keyboard>?
    public var handlerWillHide: BlockForItem<Keyboard>?
    public var handlerDidHide: BlockForItem<Keyboard>?
    
    public var handlerWillChangeFrame: BlockForItem<Keyboard>?
    public var handlerDidChangeFrame: BlockForItem<Keyboard>?
    
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
        nc.addObserver(forName: .UIKeyboardWillShow, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillShow?(keyboard)
        })
    
        /// Did Show
        nc.addObserver(forName: .UIKeyboardDidShow, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidShow?(keyboard)
        })
    
        /// Will Hide
        nc.addObserver(forName: .UIKeyboardWillHide, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillHide?(keyboard)
        })
        
        /// Did Hide
        nc.addObserver(forName: .UIKeyboardDidHide, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidHide?(keyboard)
        })
        
        /// Will Change Frame
        nc.addObserver(forName: .UIKeyboardWillChangeFrame, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerWillChangeFrame?(keyboard)
        })
        
        /// Did Change Frame
        nc.addObserver(forName: .UIKeyboardDidChangeFrame, object: nil, queue: .main, using: { (n) in
            guard let keyboard = getKeyboard(n) else { return }
            
            self.handlerDidChangeFrame?(keyboard)
        })
    }
}
