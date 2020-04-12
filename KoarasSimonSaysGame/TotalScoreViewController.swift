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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //2つ前の画面に戻りたいため、tabvarを消す。
        self.navigationController?.navigationBar.isHidden = true
        
        let getTotalScore = UserDefaults.standard.string(forKey: "totalScore")
        
        let totalScoreString: String = getTotalScore!
        let totalScoreInt: Int = Int(totalScoreString)!
        
        if totalScoreInt >= 10 {
            totalScoreLabel.text = "\(totalScoreString)点です。"
            commentLabel.text = "すごいですね"
        } else if totalScoreInt >= 5 {
            totalScoreLabel.text = "\(totalScoreString)点です。"
            commentLabel.text = "もう少しでしたね"
        } else {
            totalScoreLabel.text = "\(totalScoreString)点です。"
            commentLabel.text = "もう少し頑張りましょう"
        }
    }
    
    @IBAction func reTryButton(_ sender: Any) {
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
        
    }

}
