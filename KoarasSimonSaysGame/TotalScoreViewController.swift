//
//  TotalScoreViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/11.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class TotalScoreViewController: UIViewController {

    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
 
    var totalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //2つ前の画面に戻りたいため、tabvarを消す。
        self.navigationController?.navigationBar.isHidden = true
        
        //let getTotalScore = UserDefaults.standard.string(forKey: "totalScore")
        
//        let totalScoreString: String = getTotalScore!
//        let totalScoreInt: Int = Int(totalScoreString)!
        
        if totalScore >= 20 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.text = "すごいですね"
        } else if totalScore >= 8 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.text = "もう少しでしたね"
        } else {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.text = "もう少し頑張りましょう"
        }
    }
    
    @IBAction func goToRegisterNameButton(_ sender: Any) {
        //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view4") as! RegisterNameViewController
         nextView.totalScore = totalScore
        //画面遷移
        self.navigationController?.present       (nextView, animated: true)
    }
    
    
    @IBAction func reTryButton(_ sender: Any) {
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        
    }

}
