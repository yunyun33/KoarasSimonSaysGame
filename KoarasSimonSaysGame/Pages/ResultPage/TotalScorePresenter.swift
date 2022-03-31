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
        
        if totalScore >= 28 {
            view.showKoalasMessage(message: CommonValue.resultMessegeExcellent)
            
        } else if totalScore >= 25 {
            view.showKoalasMessage(message: CommonValue.resultMessegeAmazing)
            
        } else if totalScore >= 21 {
            view.showKoalasMessage(message: CommonValue.resultMessegeWonderful)
            
        } else if totalScore >= 16 {
            view.showKoalasMessage(message: CommonValue.resultMessegeGreat)
            
        } else if totalScore >= 5 {
            view.showKoalasMessage(message: CommonValue.resultMessegeLittleMore)
            
        } else if totalScore >= 0 {
            view.showKoalasMessage(message: CommonValue.resultMessegeSleep)
        }
        
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
