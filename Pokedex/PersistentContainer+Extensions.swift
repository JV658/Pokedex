//
//  PersistentContainer+Extensions.swift
//  Pokedex
//
//  Created by Cambrian on 2022-11-01.
//

import Foundation
import CoreData

extension NSPersistentContainer{
    func saveContext () {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
