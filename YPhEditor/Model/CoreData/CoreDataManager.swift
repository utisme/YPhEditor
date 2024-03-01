//
//  CoreDataManager.swift
//  YPhEditor
//
//  Created by Эдгар Кусков on 25.02.24.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    private let entityName = "ImageProcessingData"
    
    private lazy var context: NSManagedObjectContext = {
        let appDelegate: AppDelegate! = UIApplication.shared.delegate as? AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    // MARK: - Core Data Fetching support
    
    func fetch() -> ImageProcessingData? {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let imageProcessingData = try context.fetch(fetchRequest) as? [ImageProcessingData]
            return imageProcessingData?.first
        } catch {
            debugPrint("CoreDataManager -> fetch -> ", error)
            return nil
        }
    }
    
    // MARK: - Core Data Saving support
    
    func update(completion: (ImageProcessingData)->()) {
        
        guard let imageProcessingData = NSEntityDescription.entity(forEntityName: entityName, in: context)
        else { return }
        
        if let previousData = fetch() {
            context.delete(previousData)
        }
        
        let update = ImageProcessingData(entity: imageProcessingData, insertInto: context)
        completion(update)
        saveContext()
    }

    private func saveContext () {
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                debugPrint("AppDelegate -> saveContext -> Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
