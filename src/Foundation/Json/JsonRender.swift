//
//  JsonRender.swift
//  AEXML
//
//  Created by Virpik on 17/06/2018.
//

import Foundation

public struct JsonRender {
    
    public enum Errors: Error {
        case unknown
    }
    
    private var _raw: TMutableStore<String?> = TMutableStore(item: nil)
    private var _json: TMutableStore<Json?> = TMutableStore(item: nil)
    private var _data: TMutableStore<Data?> = TMutableStore(item: nil)
    
    public var raw: String? {
        return self._raw.item
    }
    
    public var json: Json? {
        return self._json.item
    }
    
    public var data: Data? {
        return self._data.item
    }
    
    private var isRaw: Bool = false
    private var isJson: Bool = false
    private var isData: Bool = false
    
    init(raw: String) {
        self._raw.item = raw
        self.isRaw = true
    }
    
    init(json: Json) {
        self._json.item = json
        self.isJson = true
    }
    
    init (data: Data) {
        self._data.item = data
        self.isData = true
    }
    
    public func renderRaw() throws -> String {
        do {
            let data = try self.toData()
            
            return try data.string.throw()
        } catch {
            throw error
        }
    }
    
    public func renderJson() throws -> Json {
        do {
            let data = try self.toData()
            return try (try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? Json).throw()
        } catch {
            throw error
        }
    }
    
    public func renderData() throws -> Data {
        return try self.toData()
    }
    
    // CORE
    private func toData() throws -> Data {
        if self.isJson {
            self._data.item = try self.jsonToData(json: self.json.throw())
            return try self.data.throw()
        }
        
        if self.isRaw {
            self._data.item = try self.rawToData(str: self.raw.throw())
            return try self.data.throw()
        }
        
        return try self.data.throw()
    }
    
    private func rawToData(str: String) throws -> Data {
        if let data = str.data(using: .utf8) {
            return data
        }
        
        throw Errors.unknown
    }
    
    private func jsonToData(json: Json) throws -> Data {
        return try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
    }
}
