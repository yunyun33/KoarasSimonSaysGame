
import UIKit
import AVFoundation

class PlayGameViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var koalasFlagImageView: UIImageView!
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var missLabel: UILabel!
    
    let instructionText = ["上あげて！", "下さげて！", "右にして！", "左にして！"]

    //回答を代入する変数
    var answer: String = ""
    //スコアカウント
    var okCount: Int = 0
    var missCount: Int = 0
    var totalScore: Int = 0
    
    //BGMのインスタンス生成
    var audioPlayer : AVAudioPlayer!
    
    //タイマー
           var timer : Timer?
           var count = 0
           //設定値を扱うキーを設定
           let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let randomInstructionText = instructionText.randomElement()!
        
        countDownLabel.text = "残り15秒"
        instructionLabel.text = "\(randomInstructionText)"
        
        koalasFlagImageView.image = UIImage(named: "Ready.png")

       //BGM再生
        do {
            let filePath = Bundle.main.path(forResource: "playBGM",ofType: "mp3")
            let music = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: music)
        } catch {
            print("error")
        }
        audioPlayer.play()
        
        //--------タイマーの設定--------
        //UserDefaultsのインスタンス生成
        let settingTimer = UserDefaults.standard
        //UserDefaultsに秒数を登録
        settingTimer.register(defaults: [settingKey: 15])
        
        //タイマーをアンラップ
        if let timer = timer {
            //もしタイマーが、実行中だったらスタートしない
            if timer.isValid == true {
                //何もしない
                return
            }
        }
        
        //タイマースタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)        
        
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
            nextInstructionText()
        
        } else {
            missCount += 1
            showMissLabel()
            nextInstructionText()
        }
        
        var totalScore = okCount - missCount
        //totalScoreがマイナスだったら0にする
        if totalScore < 0 {
            totalScore = 0
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
        nextView.totalScore = totalScore
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
    
    //画面の更新をする(戻り値: remainCount:残り時間)
    func displayUpdate() -> Int {
        let settingTimer = UserDefaults.standard
        //取得した秒数をtimerValueに渡す
        let timerValue = settingTimer.integer(forKey: settingKey)
        //残り時間
        let remainCount = timerValue - count
        //残り時間をラベルに表示
        countDownLabel.text = "残り\(remainCount)秒"
        //残り時間を戻り値に設定
        return remainCount
    }
    
    //時間経過の処理
    @objc func timerInterrupt(_ timer: Timer) {
        //経過時間に+1していく
        count += 1
        
        //残り時間が0以下のとき、タイマーを止める
        if displayUpdate() <= 0 {
            count = 0
            //タイマー停止
            timer.invalidate()
            showTotalScore()
            audioPlayer.stop()
        }
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
