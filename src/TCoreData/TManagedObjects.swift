//
//  [NSManagedObject][TCoreData].swift
//  EZMobile
//
//  Created by Virpik on 05/03/2018.
//  Copyright © 2018 Sybis. All rights reserved.
//

import Foundation
import CoreData

extension NSCompoundPredicate {
    convenience init(params: [(String, Any)]) {
        
        let predicates = params.map { (key, value) -> NSPredicate in
            return NSPredicate(format: "%K = %@", argumentArray: [key, value])
        }
        
        self.init(andPredicateWithSubpredicates: predicates)
    }
}

public struct TManagedObjects<T: NSManagedObject> {
    
    public typealias Sorting = (attribute: String, ascending: Bool)
    
    public var coreDataManager: TCoreDataManager
    
    public init(coreDataManager: TCoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    public var entityName: String {
        return "\(T.self.classForCoder())"
    }
    
    public func create() -> T {
        let context = self.coreDataManager.defaultContext
        
        let name = self.entityName
        
        return (NSEntityDescription.insertNewObject(forEntityName: name, into: context) as? T)!
    }
    
    @discardableResult public func delete(entitiy: T) -> Bool {
        let context = self.coreDataManager.defaultContext
        
        context.delete(entitiy)
        
        return true
    }
    
    public func entities() -> [T] {
        let name = self.entityName
        
        let request = NSFetchRequest <NSFetchRequestResult> (entityName: name)
        
        let result = self.find(with: request)
        
        return result
    }
    
    public func find(params: [(String, Any)] = [], sortBy: [Sorting] = [], fetchLimit: Int? = nil) -> [T] {
        
        let predicate = NSCompoundPredicate(params: params)
        
        let descriptors: [NSSortDescriptor] = sortBy.map { (arg) -> NSSortDescriptor in
            return NSSortDescriptor(key: arg.attribute, ascending: arg.ascending)
        }
        
        let result = self.find(predicate: predicate, sortDescriptors: descriptors, fetchLimit: fetchLimit)
        
        return result
    }
    
    public func find(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor] = [], fetchLimit: Int? = nil) ->  [T] {
        
        let name = self.entityName
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        
        request.sortDescriptors = sortDescriptors
        
        if let fetchLimit = fetchLimit {
            request.fetchLimit = fetchLimit
        }
        
        if let predicate = predicate {
            request.predicate = predicate
        }
        
        let result = self.find(with: request)
        
        return result
    }
    
    public func find(with request: NSFetchRequest<NSFetchRequestResult>) -> [T] {
        let context = self.coreDataManager.defaultContext
        
        do {
            let result = try context.fetch(request)
            return (result as? [T]) ?? []
        } catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror)")
            abort()
        }
        
        return []
    }
}

extension TManagedObjects {
    public func findFirstOrCreate(params: [(String, Any)], sortBy: [Sorting] = []) -> T {
        return self.findFirst(params: params, sortBy: sortBy) ?? self.create()
    }
    
    public func findFirst(params: [(String, Any)], sortBy: [Sorting] = []) -> T? {
        return self.find(params: params, sortBy: sortBy, fetchLimit: 1).first
    }
}

