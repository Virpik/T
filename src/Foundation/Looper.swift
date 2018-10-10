//
//  Looper.swift
//  AlertHUDKit
//
//  Created by Virpik on 16/08/2018.
//

import Foundation

open class Looper {
    
    open static let shared: Looper = {
        var looper = Looper()
        
        looper.begin()
        
        return looper
    }()
    
    open var timeDelay: TimeInterval = 1
    
    open var list: [String: Block] = [:]
    
    public init(delay: TimeInterval = 1) {
        self.timeDelay = delay
    }
    
    open func begin() {
        self.loop()
    }
    
    open func add(at key: String, block: @escaping Block) {
        self.list[key] = block
    }
    
    open func remove(at key: String) {
        self.list.removeValue(forKey: key)
    }
    
    private func loop() {
        delay(self.timeDelay, {
            self.call()
        })
    }
    
    private func call() {
        self.list.values.forEach({ $0() })
        self.loop()
    }
}

public protocol Loopable {
    var loopKey: String { get }
    
    func loopHandler()

    func loopRegister()
    func loopUnregister()
}

extension Loopable {
    public func loopRegister() {
        Looper.shared.add(at: self.loopKey, block: self.loopHandler)
    }
    
    public func loopUnregister() {
        Looper.shared.remove(at: self.loopKey)
    }
}
