//
//  RankingDataPresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/18.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation
import Firebase

protocol RankingDataPresenterInput {
    func viewDidLoad()
    func numberOfNameAndScore() -> Int
    func nameAndScore(forRow row: Int) -> [String]
    func didTapDeleteButton()
    func didTapOkOnDeleteAll()
}

protocol RankingDataOutput: AnyObject {
    func setupWordRanking()
    func setupLocalRanking()
    func reloadTableView()
    func showDeleteAlert()
    func showOkAlert(alertMessage: String)
}

class RankingDataPresenter {
    
    var isWorldRanking: Bool
    var nameAndScore: [[String]] = []
    
    private weak var view: RankingDataOutput!
    private let rankingUseCase: RankingUseCase
    
    init(isWorldRanking: Bool, view: RankingDataOutput, rankingUseCase: RankingUseCase) {
        self.isWorldRanking = isWorldRanking
        self.view = view
        self.rankingUseCase = rankingUseCase
    }
}

extension RankingDataPresenter: RankingDataPresenterInput {
    
    func viewDidLoad() {
        if isWorldRanking {
            view.setupWordRanking()
            setFirestoreDatas()
            
        } else {
            view.setupLocalRanking()
            setUserDefaultsDatas()
        }
    }
    
    func numberOfNameAndScore() -> Int {
        return nameAndScore.count
    }
    
    func nameAndScore(forRow row: Int) -> [String] {
        return nameAndScore[row]
    }
    
    func didTapDeleteButton() {
        if nameAndScore.count == 0 {
            view.showOkAlert(alertMessage: CommonValue.AlertMessage.noDataToDelete)
        } else {
            view.showDeleteAlert()
        }
    }
    
    func didTapOkOnDeleteAll() {
        //OKボタン押されたらUserDefaltsのデータ削除
        rankingUseCase.deleteRankingUserDefaultsDatas()
        //↑のだけだとボタン押した瞬間は画面に表示されたままのため↓で表示を消す
        nameAndScore.removeAll()
        view.reloadTableView()
    }
}

extension RankingDataPresenter {
    
    private func setUserDefaultsDatas() {
        nameAndScore = rankingUseCase.getRankingUserDefaultsDatas()
        
        view.reloadTableView()
    }
    
    private func setFirestoreDatas() {
        rankingUseCase.getRankingFirestoreDatas(success: { (firestoreDatas) in
            
            self.nameAndScore = firestoreDatas
            self.view.reloadTableView()
            
        }, failure: { (Error) in
            self.view.showOkAlert(alertMessage: CommonValue.AlertMessage.failedGetData)
        })
    }
}
