//
//  tCoreData.swift
//
//  Created by Virpik on 24/12/15.
//  Copyright © 2015 Virpik. All rights reserved.
//

import Foundation
import CoreData

public class TCoreDataManager: NSObject {
    public private(set) var defaultContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    public private(set) var nameDB: String
    public private(set) var sqliteName: String
    
    public var url: URL {
        return self.applicationDocumentsDirectory.appendingPathComponent(self.sqliteName)
    }
    
    private var applicationDocumentsDirectory: URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }
    
    public init(dbName name: String, sqliteName: String = "SingleViewCoreData") {
        
        self.nameDB = name
        self.sqliteName = sqliteName + ".sqlite"
        
        super.init()
        
        self.defaultContext = self.managedObjectContext(name: name)
    }
    
    public func update() {
        self.defaultContext = self.managedObjectContext(name: self.nameDB)
    }
    
    public func updateContext(managedObjectContext: AnyObject?) {
        if let context = managedObjectContext as? NSManagedObjectContext {
            self.defaultContext = self.managedObjectContext(name: self.nameDB, managedObjectContext: context)
            self.saveContext()
        }
    }
    
    
    private func managedObjectModelWithName(name: String) -> NSManagedObjectModel {
        let modelURL = Bundle.main.url(forResource: name, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }

    private func persistentStoreCoordinatorWithName(name: String) -> NSPersistentStoreCoordinator {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModelWithName(name: name))

        let options = [
            NSMigratePersistentStoresAutomaticallyOption: true,
            NSInferMappingModelAutomaticallyOption: true,
            NSSQLitePragmasOption: ["journal_mode": "WAL"]
        ] as [String : Any]
        
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: self.url, options: options)
        } catch {
            let failureReason = "There was an error creating or loading the application's saved data."
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        return coordinator
    }
    
    private func managedObjectContext(name: String, managedObjectContext: NSManagedObjectContext? = nil) -> NSManagedObjectContext {
        let coordinator = self.persistentStoreCoordinatorWithName(name: name)
        
        let managedObjectContext = managedObjectContext ?? NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        
        managedObjectContext.persistentStoreCoordinator = coordinator
        
        return managedObjectContext
    }
    
    public func saveContext () {
        let context = self.defaultContext
        
        if !context.hasChanges {
            return
        }
        
        main({
            do {
                try context.save()
                NSLog("context.save() try")
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        })
    }
}
