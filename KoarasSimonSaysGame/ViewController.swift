
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

        
    @IBAction func gameStartButton(_ sender: Any) {
        
    //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view2") as! PlayGameViewController
        
        //画面遷移
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @IBAction func onTapTest(_ sender: Any) {
        let ranking = UserDefaults.standard.string(forKey: "nameAndScore")
        print(ranking)
    }
}

