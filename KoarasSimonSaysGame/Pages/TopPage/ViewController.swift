
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
        let storyboard = UIStoryboard(name: "PlayGame", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "gameView") as! PlayGameViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapRankingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RankingData", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "RankingDataView") as! RankingDataViewController
        let rankingModel = RankingModel()
        nextView.presenter = RankingDataPresenter(isWorldRanking: false, view: nextView, model: rankingModel)
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapWorldRankingButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RankingData", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "RankingDataView") as! RankingDataViewController
        let rankingModel = RankingModel()
        nextView.presenter = RankingDataPresenter(isWorldRanking: true, view: nextView, model: rankingModel)
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
    
    @IBAction func onTapMenuButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Menu", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "menuView") as! MenuViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}
