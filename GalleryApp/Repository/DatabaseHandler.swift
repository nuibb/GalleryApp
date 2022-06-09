//
//  DatabaseHandler.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import UIKit
import RealmSwift

class DatabaseHandler {
    private(set) var context: Realm?
    
    static let shared = DatabaseHandler()
    
    init() {
        openRealm()
    }
    
    // Function to open a Realm (like a box) - needed for saving data inside of the Realm
    func openRealm() {
        do {
            // Setting the schema version
            let config = Realm.Configuration(schemaVersion: 1)
            
            // Letting Realm know we want the defaultConfiguration to be the config variable
            Realm.Configuration.defaultConfiguration = config
            
            // Trying to open a Realm and saving it into the context variable
            context = try Realm()
        } catch {
            print("Error opening Realm", error)
        }
    }
    
    // MARK: Generic function to add any kind of Realm Object
    func add<T: Object>(_ object: T) {
        if let context = context { // Need to unwrap optional, since context is optional
            do {
                // Trying to write to the context
                try context.write {
                    // Adding Object to the context
                    context.add(object)
                }
            } catch {
                print("Error adding object to Realm: \(error)")
            }
        }
    }
    
    // MARK: Function to get all items from a Realm Object
    func fetch<T: Object>(_ type: T.Type, with predicate: NSPredicate? = nil) -> [T] {
        var itemList: [T] = []
        if let context = context {
            // Getting all items from context for a Realm Object
            let items = context.objects(type)
            // Append each item to the item list array
            items.forEach { item in
                itemList.append(item)
            }
        }
        return itemList
    }
}

