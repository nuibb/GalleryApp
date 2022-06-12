//
//  DatabaseHandler.swift
//  GalleryApp
//
//  Created by ReliSource Technologies Ltd. on 6/8/22.
//

import UIKit
import RealmSwift
import Network

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
            var items: Results<T>
            if let predicate = predicate {
                items = context.objects(type).filter(predicate)
            } else {
                items = context.objects(type)
            }
            
            // Append each item to the item list array
            items.forEach { item in
                itemList.append(item)
            }
        }
        return itemList
    }
    
    func fetchById<T: Object>(id: String) -> T? {
        if let context = context {
            do {
                let objectId = try ObjectId(string: id)
                if let object = context.object(ofType: T.self, forPrimaryKey: objectId) {
                    return object
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    // Function to update a object's state
    func update<T: Object>(id: ObjectId, with predicate: NSPredicate? = nil) -> T? {
        if let context = context {
            do {
                // Find the object/'s we want to update by its id
                var itemsToUpdate: Results<T>
                if let predicate = predicate {
                    itemsToUpdate = context.objects(T.self).filter(predicate)
                } else {
                    itemsToUpdate = context.objects(T.self)
                }
                // Make sure we found the Objects and returned array isn't empty
                guard !itemsToUpdate.isEmpty else { return nil }
                // Trying to write to the context
                try context.write {
                    // Getting the first item of the array and changing its state
                    //itemsToUpdate.first.id = propery
                }
                return itemsToUpdate.first
            } catch {
                print("Error updating Object \(id) to Realm: \(error)")
            }
        }
        return nil
    }
    
    func updateById<T: Object>(id: String, newTitle: String) -> T? {
        if let context = context {
            do {
                let objectId = try ObjectId(string: id)
                let object = context.object(ofType: T.self, forPrimaryKey: objectId)
                try context.write {
                    //object?.title = newTitle
                }
                return object
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return nil
    }

    // Function to delete object/'s
    func delete<T: Object>(id: ObjectId, with predicate: NSPredicate? = nil) -> (T?, Bool) {
        if let context = context {
            do {
                // Find the object we want to delete by its id
                var itemsToDelete: Results<T>
                if let predicate = predicate {
                    itemsToDelete = context.objects(T.self).filter(predicate)
                } else {
                    itemsToDelete = context.objects(T.self)
                }
                
                // Make sure we found the objects and objectsToDelete array isn't empty
                guard !itemsToDelete.isEmpty else { return (nil, false) }
                
                // Trying to write to the context
                try context.write {
                    // Deleting the items
                    context.delete(itemsToDelete)
                }
                return (nil, true)
            } catch {
                print("Error deleting object \(id) to Realm: \(error)")
            }
        }
        return (nil, false)
    }
    
    func deleteById<T: Object>(id: String) -> (T?, Bool) {
        if let context = context {
            do {
                let objectId = try ObjectId(string: id)
                if let object = context.object(ofType: T.self, forPrimaryKey: objectId) {
                    try context.write {
                        context.delete(object)
                    }
                    return (object, true)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
        return (nil, false)
    }
}

