//
//  ViewController.swift
//  ToDoList
//
//  Created by daniel on 7/2/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var CenterLabel: UILabel!
    
    func SaveNewTask(var tasktext: String) {
        guard let AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let context = AppDelegate.persistentContainer.viewContext
        let taskentity = NSEntityDescription.entity(forEntityName: "ToDoList", in: context)!
        let task = NSManagedObject(entity: taskentity, insertInto: context)
        
        task.setValue(tasktext, forKeyPath: "task")
        
        do {
            try context.save()
        }
        catch {
            // error
        }
    }
    
    @IBAction func AddTask(_ sender: Any) {
        let alertController = UIAlertController(title: "New Item", message: "Write about your new task", preferredStyle: .alert)

        alertController.addTextField { (textField) in
            // configure the properties of the text field
            textField.placeholder = "Task..."
        }


        // add the buttons/actions to the view controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in

            // this code runs when the user hits the "save" button
            
            self.SaveNewTask(var: alertController.textFields![0].text!)
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

