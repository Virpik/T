//
//  [Date].swift
//  T
//
//  Created by Virpik on 24/06/2018.
//

import Foundation

public extension Date {
    /// Начало текущего года
    public var startOfYear: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let from = gregorian.dateComponents([.year], from: self)
        return gregorian.date(from: from)
    }
    
    /// Начало текущего месяца
    public var startOfMonth: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let from = gregorian.dateComponents([.year, .month], from: self)
        return gregorian.date(from: from)
    }
    
    /// Начало текущей недели (с понедельника)
    public var startOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let from = gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        guard let sunday = gregorian.date(from: from) else { return nil }
        return gregorian.date(byAdding: .day, value: 1, to: sunday)
    }
    
    /// Конец текущей недели
    public var endOfWeek: Date? {
        let gregorian = Calendar(identifier: .gregorian)
        let from = gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)
        guard let sunday = gregorian.date(from: from) else { return nil }
        return gregorian.date(byAdding: .day, value: 8, to: sunday)
    }
}

public extension Date {
    
    /// Возвращает колличество лет между между текущей и заданной
    public func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    /// Возвращает колличество месяцев между текущей и заданной
    public func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    
    /// Возвращает колличество недель между текущей и заданной
    public func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    
    /// Возвращает колличество дней между текущей и заданной
    public func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    /// Возвращает колличество часов между текущей и заданной
    public func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    
    /// Возвращает колличество минут между текущей и заданной
    public func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    
    /// Возвращает колличество секунд между текущей и заданной
    public func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    
    /// Возвращает колличество наносекунд между текущей и заданной
    public func nanosecond(from date: Date) -> Int {
        return Calendar.current.dateComponents([.nanosecond], from: date, to: self).nanosecond ?? 0
    }
    
    /**
    public func offset(_ date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        if nanosecond(from: date) > 0 { return ".\(nanosecond(from: date))s" }
        
        return "\(date.timeIntervalSince1970 - self.timeIntervalSince1970)"
    }*/
}

public extension DateFormatter {
    
    /// текущий DateFormatter c заданной 'UTC' тайм зоной
    public var defaultTimeZone: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = self.dateFormat
        formatter.timeZone = TimeZone(identifier: "UTC")
        return formatter
    }
    
    /// Инициализация с указанием формата
    public convenience init(format: String) {
        self.init()
        
        self.dateFormat = format
    }
}

public extension Date {
    
    /// Возвращает форматированную дату по указанному шаблону
    public func string(format: String) -> String {
        let formatter = DateFormatter(format: format)
        
        return formatter.string(from: self)
    }
    
    public struct Formatter {
        
        /// yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX
        public static let iso8601: DateFormatter = {
            let formatter = DateFormatter(format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX")
            return formatter
        }()
        
        /// yyyy-MM-dd'T'HH-mm-ss
        public static let iso1: DateFormatter = {
            let formatter = DateFormatter(format: "yyyy-MM-dd'T'HH-mm-ss")
            return formatter
        }()
        
        /// yyyy-MM-dd'T'HH-mm-ssZ
        public static let iso2: DateFormatter = {
            let formatter = DateFormatter(format: "yyyy-MM-dd'T'HH-mm-ssZ")
            return formatter
        }()
    }
    
    public var iso8601: String {
        return Formatter.iso8601.string(from: self)
    }
    
    public var iso1: String {
        return Formatter.iso1.string(from: self)
    }
    
    public var iso2: String {
        return Formatter.iso2.string(from: self)
    }
    
    public var iso8601Default: String {
        return Formatter.iso8601.defaultTimeZone.string(from: self)
    }
    
    public var iso1Default: String {
        return Formatter.iso1.defaultTimeZone.string(from: self)
    }
    
    public var iso2Default: String {
        return Formatter.iso2.defaultTimeZone.string(from: self)
    }
}
