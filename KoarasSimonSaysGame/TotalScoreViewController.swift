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

        //2つ前の画面に戻りたいため、navigationvarを消す。
        self.navigationController?.navigationBar.isHidden = true
        
        if totalScore >= 21 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "すごいですね\nあなたは旗振り名人です！"
        } else if totalScore <= 20 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "パチパチパチ\nお上手ですね"
        } else if totalScore <= 15 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "もう少しでしたね\nもう一度やってみましょう！"
        } else if totalScore <= 10 {
                totalScoreLabel.text = "\(totalScore)点です。"
                commentLabel.text = "もう少し頑張りましょう"
        } else if totalScore == 0 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "もしかして寝ていましたか？\n私も眠くなってきました..."
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
