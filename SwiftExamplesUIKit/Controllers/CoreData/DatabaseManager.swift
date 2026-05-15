//
//  DatabaseManager.swift
//  SwiftExamplesUIKit
//
//  Created by Rahul Acharya on 08/05/26.
//  Copyright © 2026 Swift Examples. All rights reserved.
//

import Foundation
import CoreData

final class DatabaseManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        
        container.loadPersistentStores { _, error in
            if let error = error as? NSError {
                fatalError("Unresolve Error: \(error), userInfo: \(error.userInfo)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext() {
        guard context.hasChanges else {
            return
        }
        
        do {
            try context.save()
        }
        catch {
         fatalError("Context error: \(error)")
        }
    }
}
