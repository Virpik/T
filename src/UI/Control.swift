//
//  TControlls.swift
//  PinLayout
//
//  Created by Virpik on 24/03/2018.
//

import Foundation

public class Control <T: UIControl>: NSObject {
    
    public let item: T
    
    public var handlerValueChanged: BlockItem<T>?
    public var handlerEditingChanged: BlockItem<T>?
    public var handlerTouchUpInside: BlockItem<T>?
    
    public init(item: T) {
        self.item = item
        
        super.init()
        
        self.item.addTarget(self, action: #selector(self._actionValueChanged), for: .valueChanged)
        self.item.addTarget(self, action: #selector(self._actionEditingChanged), for: .editingChanged)
        self.item.addTarget(self, action: #selector(self._actionTouchUpInside), for: .touchUpInside)
    }
    
    // .touchUpInside
    @objc func _actionTouchUpInside(sender: Any?) {
        self.worker(sender: sender, handler: self.handlerTouchUpInside)
    }
    
    // .editingChanged
    @objc func _actionEditingChanged(sender: Any?) {
        self.worker(sender: sender, handler: self.handlerEditingChanged)
    }
    
    // .valueChanged
    @objc func _actionValueChanged(sender: Any?) {
        self.worker(sender: sender, handler: self.handlerValueChanged)
    }
    
    func worker(sender: Any?, handler: BlockItem<T>?) {
        guard let _item = sender as? T else {
            return
        }
        
        handler?(_item)
    }
}
