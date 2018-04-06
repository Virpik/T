//
//  TControlls.swift
//  PinLayout
//
//  Created by Virpik on 24/03/2018.
//

import Foundation

public class TControl <T: UIControl>: NSObject {
    
    public let item: T
    
    public var handlerValueChanged: BlockForItem<T>?
    public var handlerEditingChanged: BlockForItem<T>?
    
    public init(item: T) {
        self.item = item
        
        super.init()
        
        self.item.addTarget(self, action: #selector(self._actionValueChanged), for: .valueChanged)
        self.item.addTarget(self, action: #selector(self._actionEditingChanged), for: .editingChanged)
    }
    
    // .editingChanged
    @objc func _actionEditingChanged(sender: Any?) {
        guard let _item = sender as? T else {
            return
        }
        
        self.handlerEditingChanged?(_item)
    }
    
    // .valueChanged
    @objc func _actionValueChanged(sender: Any?) {
        
        guard let _item = sender as? T else {
            return
        }
        
        self.handlerValueChanged?(_item)
    }
}