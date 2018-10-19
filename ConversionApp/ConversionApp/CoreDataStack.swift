//
//  CoreDataStack.swift
//  ConversionApp
//
//  Created by Marko Satlan on 19/10/2018.
//  Copyright © 2018 Marko Satlan. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    private let modelName: String
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.modelName)
        container.loadPersistentStores(completionHandler: { storeDescription, error in
            if let error = error as NSError? {
                print("Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    func saveContext() {
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Save error \(error), \(error.userInfo)")
        }
        
    }
}
