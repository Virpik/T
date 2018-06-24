//
//  TData.swift
//  TDemo
//
//  Created by Virpik on 31/10/2017.
//  Copyright © 2017 Virpik. All rights reserved.
//

import Foundation

public extension Data {
    
    public init?(fileName: String, bundle: Bundle = Bundle.main) {
        guard let path = bundle.path(forResource: fileName, ofType: "json") else {
            return nil
        }

        do {
            let url = URL(fileURLWithPath: path)
            try self = Data(contentsOf: url, options: .mappedIfSafe)
            return
        } catch {
            return nil
        }
    }

    public var json: [[AnyHashable: Any]]? {
        do {
            let jsonResult = try JSONSerialization.jsonObject(with: self, options: .mutableLeaves)
            
            if let jsonResult = jsonResult as? [[AnyHashable: Any]] {
                return jsonResult
            }
            
            if let  jsonResult = jsonResult as? [AnyHashable: Any] {
                return [jsonResult]
            }
            
            return nil
        } catch {
            return nil
        }
    }
    
    public var string: String? {
        return String(data: self, encoding: .utf8)
    }
}
