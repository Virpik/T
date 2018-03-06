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

    public func find(params: [(String, Any)], sortBy attribute: String?, ascending: Bool, fetchLimit: Int? = nil) -> [T] {
        
        let predicate = NSCompoundPredicate(params: params)
        let descriptor = NSSortDescriptor(key: attribute, ascending: ascending)
        
        let result = self.find(predicate: predicate, sortDescriptors: [descriptor], fetchLimit: fetchLimit)
        
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

    public func findFirstOrCreate(attribute: String, value: Any) -> T {
        return self.findFirstOrCreate(params: [(attribute, value)])
    }

    public func findFirstOrCreate(params: [(String, Any)]) -> T {
        if let entity = self.findFirst(params: params) {
            return entity
        }
        
        return self.create()
    }


    public func findFirst(params: [(String, Any)]) -> T? {
        let name = self.entityName
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        request.fetchLimit = 1
        request.predicate = NSCompoundPredicate(params: params)
        
        let result = self.find(with: request)
        
        return result.first
    }

    public func findFirst(attribute: String, value: Any) -> T? {
        return self.findFirst(params: [(attribute, value)])
    }

    public func findFirst(sortBy attribute: String, ascending: Bool) -> T? {
        let descriptor = NSSortDescriptor(key: attribute, ascending: ascending)
        return self.find(sortDescriptors: [descriptor], fetchLimt: 1).first
    }

    public func find(sortBy attribute: String, ascending: Bool) -> [T] {
        let descriptor = NSSortDescriptor(key: attribute, ascending: ascending)
        return self.find(sortDescriptors: [descriptor])
    }

    public func find(sortDescriptors: [NSSortDescriptor] = [], fetchLimt: Int? = nil) -> [T] {
        let name = self.entityName
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: name)
        
        if let fetchLimt = fetchLimt {
            request.fetchLimit = fetchLimt
        }
        
        request.sortDescriptors = sortDescriptors
        
        return self.find(with: request)
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
