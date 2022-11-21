//
//  DataManager.swift
//  CarMarketplace
//
//  Created by Jaqueline Oliveira on 20/11/22.
//

import Foundation
import CoreData

class DataManager {
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Database")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}
