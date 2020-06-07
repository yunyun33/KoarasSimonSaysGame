
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationcontorollerを消す
        navigationController?.navigationBar.isHidden = true
    }

        
    @IBAction func gameStartButton(_ sender: Any) {
        
    //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view2") as! PlayGameViewController
        //画面遷移
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapRankingButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "view5") as! RankingDateViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }

}
