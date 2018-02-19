//
//  [UIView][T][Visual].swift
//  T
//
//  Created by Virpik on 19/02/2018.
//
import Foundation

extension UIView.Ext_View {
    public func hidde(duration: TimeInterval, completion: Block? = nil) {
        let alpha = self.origin.alpha
        
        UIView.animate(withDuration: duration, animations: {
            self.origin.alpha = 0
        }) { (_) in
            self.origin.isHidden = true
            self.origin.alpha = alpha
            completion?()
        }
    }
    
    public func show(alpha: CGFloat = 1 ,duration: TimeInterval, completion: Block? = nil) {
        self.origin.alpha = 0
        self.origin.isHidden = false
        
        UIView.animate(withDuration: duration, animations: {
            self.origin.alpha = alpha
        }) { (_) in
            completion?()
        }
    }
    
    public func selfdestruction(isAnimation: Bool = true, after: TimeInterval = 1, handler: Block? = nil) {
        delay(after) {
            if !isAnimation {
                self.origin.removeFromSuperview()
                handler?()
                return
            }
            
            self.hidde(duration: 0.2) {
                self.origin.removeFromSuperview()
                handler?()
            }
        }
    }
    
    
    public func shake () {
        let midX = self.origin.frame.midX
        let midY = self.origin.frame.midY
        
        let animation = CABasicAnimation(keyPath: "position")
        
        animation.duration = 0.06
        animation.repeatCount = 4
        animation.autoreverses = true
        
        animation.fromValue = CGPoint(x: midX - 10, y: midY)
        animation.toValue = CGPoint(x: midX + 10, y: midY)
        
        self.origin.layer.add(animation, forKey: "position")
    }
}
