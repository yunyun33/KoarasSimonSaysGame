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
    @IBOutlet weak var messageLabel: UILabel!
 
    var totalScore: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = TotalScorePresenter(totalScore: totalScore, view: self)

        presenter.setResult()
        
        //2つ前の画面に戻りたい(直接ゲーム画面には戻さない)ため、navigationvarを消す。
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToRegisterNameButton(_ sender: Any) {
        let totalScoreVC = UIStoryboard(name: "RegisterNameDialog", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "RegisterNameDialogView") as! RegisterNameViewController
         nextView.totalScore = totalScore
        self.navigationController?.present(nextView, animated: true)
    }
    
    @IBAction func reTryButton(_ sender: Any) {
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
    }
}

extension TotalScoreViewController: TotalScorePresenterOutput {
    
    func showTotalScore(totalScore: Int) {
        totalScoreLabel.text = "\(totalScore)点です。"
    }
    
    func showKoalasMessage(message: String) {
        messageLabel.text = message
    }
}
