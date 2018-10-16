//
//  Looper.swift
//  AlertHUDKit
//
//  Created by Virpik on 16/08/2018.
//

import Foundation

/// Простой таймер. Запускает заданные блоки через указанный интервал времени
/// Потоко не безопасен, Аккуратнее
open class Looper {
    /// Главный цикл. Необходим для потдержки протокола 'Loopable'
    public static let shared: Looper = {
        var looper = Looper()
        
        looper.begin()
        
        return looper
    }()
    
    /// Интревал
    open var timeDelay: TimeInterval = 1
    /// Список блоков по ключу
    open var list: [String: Block] = [:]
    
    public init(delay: TimeInterval = 1) {
        self.timeDelay = delay
    }
    
    /// Запуск цикла
    open func begin() {
        self.loop()
    }
    
    /// Добавляет / заменяет блок по ключу
    open func add(at key: String, block: @escaping Block) {
        self.list[key] = block
    }
    
    /// Удаляет блок по ключу
    open func remove(at key: String) {
        self.list.removeValue(forKey: key)
    }
    
    private func loop() {
        delay(self.timeDelay, { [weak self] in
            self?.call()
        })
    }
    
    private func call() {
        self.list.values.forEach({ $0() })
        self.loop()
    }
}

/// Протокол, для унификации использования Looper-а
///
/// Для работы в главном цикле, необходимо реализовать:
/// - var loopKey: String - Ключ обьека
/// - func loopHandler() - метод, который будет запускаться в виде блока
///
/// Для запуска в отдельном цикле, необходимо реализовать методы регистрации и удаления в произвольном обьекте 'Looper':
/// - func loopRegister()
/// - func loopUnregister()
///
/// Для подключения к циклу вызываем:
/// - func loopRegister()
///
/// Для выода из цикла необходимо вызвать:
/// - func loopUnregister()
///
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
