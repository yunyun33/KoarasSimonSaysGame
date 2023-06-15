//
//  TotalScorePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/14.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol TotalScorePresenterInput {
    func viewDidLoad()
    func didTapRegisterNameButton()
    func didTapReTryButton()
}

protocol TotalScorePresenterOutput: AnyObject {
    func showTotalScore(totalScore: Int)
    func showKoalasMessage(message: String)
    func transitToRegisterName(totalScore: Int)
    func backToTopPage()
}

class TotalScorePresenter: TotalScorePresenterInput {
    
    var totalScore: Int
    
    private weak var view: TotalScorePresenterOutput!
    
    init(totalScore: Int, view: TotalScorePresenterOutput) {
        self.totalScore = totalScore
        self.view = view
    }
    
    //TotalScoreを見て、スコアに合ったコアラさんのメッセージを表示
    func viewDidLoad() {
        view.showTotalScore(totalScore: totalScore)
        
        // TODO: 一旦ここで直接TotalScoreModel()をinitしてテストの実装を確認する
        let message = TotalScoreModel().getKoalasMessage(totalScore: totalScore)
        view.showKoalasMessage(message: message)
        
        // 診断結果の表示イベントを、パーセントのパラメータとともにロギングする
        AnalyticsManager.logShowResultEvent(with: totalScore)
    }
    
    func didTapRegisterNameButton() {
        view.transitToRegisterName(totalScore: totalScore)
    }
    
    func didTapReTryButton() {
        view.backToTopPage()
    }
}
