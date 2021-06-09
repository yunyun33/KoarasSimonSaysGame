
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationcontorollerを消す
        navigationController?.navigationBar.isHidden = true
        
        // 次の画面のBackボタンを「戻る」に変更
           self.navigationItem.backBarButtonItem = UIBarButtonItem(
               title:  "戻る",
               style:  .plain,
               target: nil,
               action: nil
           )
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
        nextView.isWorldRanking = false
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapWorldRankingButton(_ sender: Any) {
        let storyboard: UIStoryboard = self.storyboard!
        let nextView = storyboard.instantiateViewController(withIdentifier: "view5") as! RankingDateViewController
        nextView.isWorldRanking = true
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapMenuButton(_ sender: Any) {
        let menuVC = UIStoryboard(name: "Menu", bundle: nil)
        let nextView = menuVC.instantiateViewController(withIdentifier: "menuView") as! MenuViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}
