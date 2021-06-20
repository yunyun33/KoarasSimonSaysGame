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
}

protocol RankingDataOutput: AnyObject {
    func setupWordRanking()
    func setupLocalRanking()
    func reloadTableView()
}

class RankingDataPresenter {
    
    var isWorldRanking: Bool
    var nameAndScore: [[String]] = []
        
    private weak var view: RankingDataOutput!
    
    init(isWorldRanking: Bool, view: RankingDataOutput) {
        self.isWorldRanking = isWorldRanking
        self.view = view
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
}

extension RankingDataPresenter {
    
    private func getUserDefaultsDatas() {
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            nameAndScore = savedname
        }
        view.reloadTableView()
    }
}
