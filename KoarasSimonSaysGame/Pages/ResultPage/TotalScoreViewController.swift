//
//  TotalScoreViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/11.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class TotalScoreViewController: UIViewController {
    
    var presenter: TotalScorePresenterInput!
    
    @IBOutlet weak var totalScoreLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.viewDidLoad()
        
        //2つ前の画面に戻りたい(直接ゲーム画面には戻さない)ため、navigationvarを消す。
        self.navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func goToRegisterNameButton(_ sender: Any) {
        presenter.didTapRegisterNameButton()
    }
    
    @IBAction func reTryButton(_ sender: Any) {
        presenter.didTapReTryButton()
    }
}

extension TotalScoreViewController: TotalScorePresenterOutput {
    
    func showTotalScore(totalScore: Int) {
        totalScoreLabel.text = "\(totalScore)点です。"
    }
    
    func showKoalasMessage(message: String) {
        messageLabel.text = message
    }
    
    func transitToRegisterName(totalScore: Int) {
        let totalScoreVC = UIStoryboard(name: "RegisterNameDialog", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "RegisterNameDialogView") as! RegisterNameViewController
        let rankingModel = RankingModel()
        nextView.presenter = RegisterNamePresenter(totalScore: totalScore, view: nextView, model: rankingModel)
        self.navigationController?.present(nextView, animated: true)
    }
    
    func backToTopPage() {
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
    }
}
