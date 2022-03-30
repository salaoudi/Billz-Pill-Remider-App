//
//  CoreDataManager.swift
//  Billz
//
//  Created by Zayn on 1/27/22.
//

import Foundation
import CoreData


class CoreDataManager: ObservableObject {
    
    static let instance = CoreDataManager()
    let container: NSPersistentContainer
    let context: NSManagedObjectContext
    
    
    init() {
        container = NSPersistentContainer(name: "Billz")
        container.loadPersistentStores { (core, error) in
            if let error = error {
                print("error\(error.localizedDescription)")
            }
        }
        context = container.viewContext
   
    }
    
    
    //Save to core data
 func save() {
     do {
         try container.viewContext.save()
     } catch {
         print("Error in MorningViewModal, save() Function")
     }
 }
    
}
