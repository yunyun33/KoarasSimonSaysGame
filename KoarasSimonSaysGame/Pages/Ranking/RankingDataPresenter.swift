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
    func showCanNotDeleteAlert()
}

class RankingDataPresenter {
    
    var isWorldRanking: Bool
    var nameAndScore: [[String]] = []
        
    private weak var view: RankingDataOutput!
    private let model: RankingModelProtocol
    
    init(isWorldRanking: Bool, view: RankingDataOutput, model: RankingModelProtocol) {
        self.isWorldRanking = isWorldRanking
        self.view = view
        self.model = model
    }
}

extension RankingDataPresenter: RankingDataPresenterInput {

    func viewDidLoad() {
        if isWorldRanking {
            view.setupWordRanking()
//            getFirestoreDatas()
        } else {
            view.setupLocalRanking()
            getUserDefaultsDatas()
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
            view.showCanNotDeleteAlert()
        } else {
            view.showDeleteAlert()
        }
    }
    
    func didTapOkOnDeleteAll() {
        //OKボタン押されたらUserDefaltsのデータ削除
        model.deleteToUserDefaultsDatas()
        //↑のだけだとボタン押した瞬間は画面に表示されたままのため↓で表示を消す
        nameAndScore.removeAll()
        view.reloadTableView()
    }
}

extension RankingDataPresenter {
    
    private func getUserDefaultsDatas() {
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            nameAndScore = savedname
        }
        view.reloadTableView()
    }
}
