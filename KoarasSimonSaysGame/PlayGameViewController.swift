
import UIKit

class PlayGameViewController: UIViewController {

    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var koalasFlagImageView: UIImageView!
    
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var missLabel: UILabel!
    
    let instructionText = ["上あげて！", "下さげて！", "右あげて！", "左あげて！"]

    //回答を代入する変数
    var answer: String = ""
    //正解カウント数
    var okCount: Int = 0
    //ミスカウント数
    var missCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let randomInstructionText = instructionText.randomElement()!
        
        instructionLabel.text = "\(randomInstructionText)"
        
        koalasFlagImageView.image = UIImage(named: "Ready.png")

        //goodLabelをアニメーションするまで透明にしておく
        goodLabel.alpha = 0.0
        missLabel.alpha = 0.0
    }
    
    //--------旗揚げゲーム--------
    @IBAction func upButton(_ sender: Any) {
        goToNextQuestion(tappedString: instructionText[0])
    }
    
    @IBAction func downButton(_ sender: Any) {
        goToNextQuestion(tappedString: instructionText[1])
    }
    
    @IBAction func rightButton(_ sender: Any) {
        goToNextQuestion(tappedString: instructionText[2])
    }
    
    @IBAction func leftButton(_ sender: Any) {
        goToNextQuestion(tappedString: instructionText[3])
    }
    
    func goToNextQuestion(tappedString: String) {
        answer = tappedString
        
        //正解の判定をする
        if instructionLabel.text == answer {
            okCount += 1
            showGoodLabel()
            
            if okCount == 10 {
                
                let totalCount: Int = okCount - missCount
                print(okCount)
                print(missCount)
                UserDefaults.standard.set(totalCount, forKey: "totalScore")
                
                showTotalScore()
                
            } else {
                //次の問題を用意する
                nextInstructionText()
            }

        } else {
            missCount += 1
            showMissLabel()
        }
        
        //画像を切り替える
        switch tappedString {
            case instructionText[0]: koalasFlagImageView.image = UIImage(named: "Up.png")
            case instructionText[1]: koalasFlagImageView.image = UIImage(named: "Down.png")
            case instructionText[2]: koalasFlagImageView.image = UIImage(named: "Right.png")
            case instructionText[3]: koalasFlagImageView.image = UIImage(named: "Left.png")
            default: break
        }
    }
    
    private func showTotalScore() {
        //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view3") as! TotalScoreViewController
        //画面遷移
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    //問題を表示する
    private func nextInstructionText() {
        let randomInstructionText = instructionText.randomElement()!
            instructionLabel.text = "\(randomInstructionText)"
    }
    
    //正解したらgoodLabel表示
    private func showGoodLabel() {
        goodLabel.center = self.view.center
        goodLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.goodLabel.center.y -= 120.0
            self.goodLabel.alpha = 0.0
        }, completion: nil)
    }
    
    //間違えたらmissLabel表示
    private func showMissLabel() {
        missLabel.center = self.view.center
        missLabel.alpha = 1.0
        UIView.animate(withDuration: 0.5, delay: 0.0, animations: {
            self.missLabel.center.y -= 120.0
            self.missLabel.alpha = 0.0
        }, completion: nil)
    }
    
    //制作用スキップボタン
    @IBAction func skipButton(_ sender: Any) {
        //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view3") as! TotalScoreViewController
        self.navigationController?.pushViewController(nextView, animated: true)
    }
}
