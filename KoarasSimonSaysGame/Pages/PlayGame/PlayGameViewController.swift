
import UIKit
import AVFoundation

class PlayGameViewController: UIViewController, AVAudioPlayerDelegate, UINavigationControllerDelegate {
    
    private var presenter: PlayGamePresenterInput!

    @IBOutlet weak var instructionLabel: UILabel!
    
    @IBOutlet weak var koalasFlagImageView: UIImageView!
    
    @IBOutlet weak var countDownLabel: UILabel!
    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var missLabel: UILabel!

    //回答を代入する変数
    var answer: String = ""
    //スコアカウント
    var scoreCount: Int = 0
    
    //BGMのインスタンス生成
    var audioPlayer : AVAudioPlayer!
    
    //タイマー
    var timer : Timer?
    var count = 0
    //設定値を扱うキーを設定
    let settingKey = "timerValue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PlayGamePresenter(view: self)

        //navigationBarの戻るボタン押した時のイベントに必要
        navigationController?.delegate = self
        
        // ナビゲーションバーの透明化
        // 半透明の指定（デフォルト値）
        self.navigationController?.navigationBar.isTranslucent = true
        // 空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
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
        
        setTimer()

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
            scoreCount += 1
            showGoodLabel()
            nextInstructionText()
        } else {
            scoreCount -= 1
                if scoreCount < 0 {
                    scoreCount = 0
                }
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
        let totalScoreVC = UIStoryboard(name: "Main", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "totalScorewView") as! TotalScoreViewController
        self.navigationController?.pushViewController(nextView, animated: true)
        navigationController?.navigationBar.isHidden = false
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
            //タイマー停止,停止と一緒に実行すること
            timer.invalidate()
            showTotalScore()
            audioPlayer.stop()
        }
    }
    
    //タイマーの設定
    func setTimer() {
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
    }
    
    //navigationBarの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            //タイマー停止,BGM停止
            timer?.invalidate()
            audioPlayer.stop()
            navigationController.navigationBar.isHidden = true
        }
    }
}

extension PlayGameViewController: PlayGamePresenterOutput {
}
