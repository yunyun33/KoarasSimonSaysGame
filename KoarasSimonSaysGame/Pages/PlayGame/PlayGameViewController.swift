
import UIKit

class PlayGameViewController: UIViewController,  UINavigationControllerDelegate {
    
    private var presenter: PlayGamePresenterInput!

    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var koalasFlagImageView: UIImageView!
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var missLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PlayGamePresenter(view: self)
        
        presenter.viewDidLoad()
    }
   
    //--------旗上げゲーム--------
    @IBAction func upButton(_ sender: Any) {
        presenter.didTapDirectionButton(tappedDirection: .UP)
    }
    
    @IBAction func downButton(_ sender: Any) {
        presenter.didTapDirectionButton(tappedDirection: .DOWN)
    }
    
    @IBAction func rightButton(_ sender: Any) {
        presenter.didTapDirectionButton(tappedDirection: .RIGHT)
    }
    
    @IBAction func leftButton(_ sender: Any) {
        presenter.didTapDirectionButton(tappedDirection: .LEFT)
    }
    
    //ナビゲーションバーの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            //タイマー停止,BGM停止
            presenter.didTapBackButton()
            navigationController.navigationBar.isHidden = true
        }
    }
}

extension PlayGameViewController: PlayGamePresenterOutput {
    
    func setupUI() {
        //ナビゲーションバーの戻るボタン押した時のイベントに必要
        navigationController?.delegate = self
        
        //ナビゲーションバーの透明化
        //透明の指定（デフォルト値）
        self.navigationController?.navigationBar.isTranslucent = true
        //空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        //ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        countDownLabel.text = "残り15秒"
        
        koalasFlagImageView.image = UIImage(named: "Ready.png")
        
        //goodLabelをアニメーションするまで透明にしておく
        goodLabel.alpha = 0.0
        missLabel.alpha = 0.0
    }
    
    func setCountDownLabel(timerCount: Int) {
        countDownLabel.text = "残り\(timerCount)秒"
    }
    
    //正解したらgoodLabel表示
    func showGoodLabel() {
        goodLabel.center = self.view.center
        goodLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.goodLabel.center.y -= 120.0
            self.goodLabel.alpha = 0.0
        }, completion: nil)
    }
    
    //間違えたらmissLabel表示
    func showMissLabel() {
        missLabel.center = self.view.center
        missLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.missLabel.center.y -= 120.0
            self.missLabel.alpha = 0.0
        }, completion: nil)
    }
    
    //方向指示を表示
    func showNextInstruction(direction: Direction) {
        instructionLabel.text = direction.getInstructionText()
    }
    
    //画像を切り替える
    func setFlagImage(direction: Direction) {
        koalasFlagImageView.image = direction.getFlagImage()
    }
    
    func transitToTotalScorePage(score: Int) {
        let totalScoreVC = UIStoryboard(name: "TotalScore", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "totalScoreView") as! TotalScoreViewController
        nextView.totalScore = score
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}
