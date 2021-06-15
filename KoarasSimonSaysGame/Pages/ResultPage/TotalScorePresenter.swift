//
//  TotalScorePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/14.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol TotalScorePresenterInput {
    func setResult(totalScore: Int)
}

protocol TotalScorePresenterOutput: AnyObject {
    func showTotalScore(totalScore: Int)
    func showKoalasMessage(message: String)
}

class TotalScorePresenter: TotalScorePresenterInput {
    
    private weak var view: TotalScorePresenterOutput!
    
    init(view: TotalScorePresenterOutput) {
        self.view = view
    }
    
    //TotalScoreを見て、スコアに合ったコアラさんのメッセージを表示
    func setResult(totalScore: Int) {
        if totalScore >= 28 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeExcellent)
            
        } else if totalScore >= 25 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeAmazing)
            
        } else if totalScore >= 21 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeWonderful)

        } else if totalScore >= 16 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeGreat)

        } else if totalScore >= 5 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeLittleMore)

        } else if totalScore >= 0 {
            view.showTotalScore(totalScore: totalScore)
            view.showKoalasMessage(message: CommonValue.resultMessegeSleep)
        }
    }
}
