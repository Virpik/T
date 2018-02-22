//
//  [TView][Debug].swift
//  Pods-TDemo
//
//  Created by Virpik on 31/01/2018.
//

import Foundation

extension UIView.Ext_View {
    static func point(at center: CGPoint) -> UIView {
        let bgColor = UIColor.red.t.transparency(0.3)
        let crosshairsBgColor = UIColor.green.t.transparency(0.3)
        
        let frameSize = CGSize(width: 20, height: 20)
        
        let crosshairsWidth: CGFloat = 1
        
        let view = UIView(size: frameSize)
        
        view.backgroundColor = bgColor
        view.tBRadius = (min(frameSize.width, frameSize.height)/2.cgFloat).float
        
        view.clipsToBounds = true
        
        view.center = center
        
        let _hView = UIView(width: frameSize.width, height: crosshairsWidth)
        let _wView = UIView(width: crosshairsWidth, height: frameSize.height)
        
        _wView.center = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        _hView.center = CGPoint(x: frameSize.width/2, y: frameSize.height/2)
        
        _hView.backgroundColor = crosshairsBgColor
        _wView.backgroundColor = crosshairsBgColor
        
        view.t_view.addSubview(view: _hView)
        view.t_view.addSubview(view: _wView)
        
        return view
    }
}
