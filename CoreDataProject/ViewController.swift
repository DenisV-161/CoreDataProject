
import UIKit
import CoreData

class ViewController: UIViewController {
    
    var todoList: [Task] = []
    var taskNumber: Int = 0
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var newTaskTextField: UITextField!
    
    @IBOutlet weak var infoTextLabel: UILabel!
    
    @IBAction func addTaskButton(_ sender: Any) {
        
        if let newTask = newTaskTextField.text {
            taskNumber = todoList.count
            infoTextLabel.textColor = .red
            guard newTask != "" else { return infoTextLabel.text = "Task field is empty" }
            todoList.append(Persistance.shared.saveTask(withName: newTask)!)
            tableView.reloadData()
            infoTextLabel.textColor = .gray
            infoTextLabel.text = "New task № \(taskNumber + 1) has been added"
            taskNumber += 1
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        todoList = Persistance.shared.fetchData()!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoTableViewCell") as! TodoTableViewCell
        let task = todoList[indexPath.row]
        cell.numberOfTask.text = String(indexPath.row + 1)
        cell.taskLabel.text = task.taskName
        cell.delegate = self

        return cell
    }

}

extension ViewController: TodoTableViewCellDelegate{
    func removeTask(sender: Any) {

        if let cell = (sender as AnyObject).superview?.superview as? TodoTableViewCell, let index = tableView.indexPath(for: cell) {

            if Persistance.shared.removeTask(index: index.row)! {
            todoList.remove(at: index.row)
            }
            infoTextLabel.textColor = .gray
            infoTextLabel.text = "Task № \(index.row + 1) has been removed"
        } else {infoTextLabel.text = "Error. Deletion isn'n posible"}
        tableView.reloadData()
    }

}
