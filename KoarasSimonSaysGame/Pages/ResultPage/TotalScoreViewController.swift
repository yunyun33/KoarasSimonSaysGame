//
//  TotalScoreViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/11.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class TotalScoreViewController: UIViewController {
    
    private var presenter: TotalScorePresenterInput!

    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
 
    var totalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TotalScorePresenter(view: self)

        //2つ前の画面に戻りたいため、navigationvarを消す。
        self.navigationController?.navigationBar.isHidden = true
        
        if totalScore >= 25 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "す、すごい！\nあなたの弟子にしてください！"
        } else if totalScore >= 21 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "すごいですね\nあなたは旗振り名人です！"
        } else if totalScore >= 16 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "パチパチパチ\nお上手ですね"
        } else if totalScore >= 11 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "もう少しでしたね\nもう一度やってみましょう！"
        } else if totalScore >= 1 {
                totalScoreLabel.text = "\(totalScore)点です。"
                commentLabel.text = "もう少し頑張りましょう"
        } else if totalScore == 0 {
            totalScoreLabel.text = "\(totalScore)点です。"
            commentLabel.numberOfLines = 2
            commentLabel.text = "もしかして寝ていましたか？\n私も眠くなってきました..."
        }
    }
    
    @IBAction func goToRegisterNameButton(_ sender: Any) {
        let totalScoreVC = UIStoryboard(name: "RegisterNameDialog", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "RegisterNameDialogView") as! RegisterNameViewController
         nextView.totalScore = totalScore
        //画面遷移
        self.navigationController?.present(nextView, animated: true)
    }
    
    @IBAction func reTryButton(_ sender: Any) {
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        
    }
}

extension TotalScoreViewController: TotalScorePresenterOutput {
    
}
