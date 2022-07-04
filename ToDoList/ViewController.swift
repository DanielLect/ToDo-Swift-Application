//
//  ViewController.swift
//  ToDoList
//
//  Created by daniel on 7/3/22.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var tasklist: [NSManagedObject] = []

    @IBOutlet weak var tableView: UITableView!
    
    func SaveNewTask(tasktext: String) {
        
        guard let AppDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
            
        let context = AppDelegate.persistentContainer.viewContext
        let taskentity = NSEntityDescription.entity(forEntityName: "TaskEntity", in: context)!
        let task = NSManagedObject(entity: taskentity, insertInto: context)
            
        task.setValue(tasktext, forKeyPath: "task")
            
        do {
            try context.save()
            self.tasklist.append(task)
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
            let text: String = alertController.textFields![0].text!
            self.SaveNewTask(tasktext: text)
            self.tableView.reloadData()
        }

        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)

        present(alertController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Tasks"
        tableView.register(UITableViewCell.self,forCellReuseIdentifier: "Cell")
    }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return tasklist.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let task = tasklist[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = task.value(forKeyPath: "task") as? String
    return cell
  }
}
