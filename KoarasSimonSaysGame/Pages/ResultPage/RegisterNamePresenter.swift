//
//  RegisterNamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/16.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import UIKit

protocol RegisterNamePresenterInput {
    func didTapRegisterButton(nameText: String?, worldRankingSwith: Bool)
//    func didCheckWordRanking(nameText: String?)
    func didTapButton()
}

protocol RegisterNamePresenterOutput: AnyObject {
    func backToTopPage()
}

class RegisterNamePresenter: RegisterNamePresenterInput {
    
    var totalScore: Int
    var rankingArray: [String] = []
    
    private weak var view: RegisterNamePresenterOutput!
    private let model: RankingModelProtocol
    
    init(totalScore: Int, view: RegisterNamePresenterOutput, model: RankingModelProtocol) {
        self.totalScore = totalScore
        self.view = view
        self.model = model
    }
    
    func didTapRegisterButton(nameText: String?, worldRankingSwith: Bool) {
        model.saveToUserDefaults(name: nameText ?? "", score: totalScore)
        
        if worldRankingSwith == true {
            model.seveToFirestore(name: nameText ?? "", score: totalScore)
        }
    }
    
//    func didCheckWordRanking(nameText: String?) {
//        model.seveToFirestore(name: nameText ?? "", score: totalScore)
//    }
    
    func didTapButton() {
        view.backToTopPage()
    }
}

extension RegisterNamePresenter {
    
//    private func saveRanking(nameText: String?) {
//        model.saveToUserDefaults(name: nameText ?? "", score: totalScore)
//    }
}
