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
}

protocol RankingDataOutput: AnyObject {
    func setupWordRanking()
    func setupLocalRanking()
}

class RankingDataPresenter: RankingDataPresenterInput {
    
    var isWorldRanking: Bool
    
    var presenter: RankingDataPresenterInput!
    
    private weak var view: RankingDataOutput!
    
    init(isWorldRanking: Bool, view: RankingDataOutput) {
        self.isWorldRanking = isWorldRanking
        self.view = view
    }
    
    func viewDidLoad() {
        if isWorldRanking == true {
            view.setupWordRanking()
//            getFirestoreDatas()
        } else {
            view.setupLocalRanking()
//            getUserDefaultsDatas()
        }
    }
}
