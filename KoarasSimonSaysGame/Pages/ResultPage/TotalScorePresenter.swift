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
    private let model: TotalScoreModel
    
    init(totalScore: Int, view: TotalScorePresenterOutput, model : TotalScoreModel) {
        self.totalScore = totalScore
        self.view = view
        self.model = model
    }
    
    func viewDidLoad() {
        view.showTotalScore(totalScore: totalScore)
        
        // TotalScoreを見て、スコアに合ったコアラさんのメッセージを表示
        let message = model.getKoalasMessage(totalScore: totalScore)
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
