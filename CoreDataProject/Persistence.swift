
import Foundation
import CoreData
import UIKit

class Persistance {
    
    static let shared = Persistance()
    
    func saveTask (withName name: String) -> Task? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Task", in: context) else { return nil }
        let taskObject = Task(entity: entity, insertInto: context)
        taskObject.taskName = name
        
        do {
            try context.save()
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        return taskObject
    }
    
    func fetchData() -> [Task]? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        let objects = try? context.fetch(fetchRequest)
        
        return objects
    }
    
    func removeTask(index: Int) -> Bool? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        
        if let tasks = try? context.fetch(fetchRequest){
            let task = tasks[index]
            context.delete(task)
            do {
                try context.save()
            } catch let error as NSError{
                print(error.localizedDescription)
            }
        } else { return nil }
        return true
    }
    
}
