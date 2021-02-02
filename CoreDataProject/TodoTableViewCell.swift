
import UIKit

    protocol TodoTableViewCellDelegate: NSObjectProtocol {
        func removeTask(sender: Any)
    }

class TodoTableViewCell: UITableViewCell {

    weak var delegate: TodoTableViewCellDelegate?

    @IBOutlet weak var numberOfTask: UILabel!
    
    @IBOutlet weak var taskLabel: UILabel!
    
    @IBAction func removeTaskButton(_ sender: Any) {
        
        delegate?.removeTask(sender: sender)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
