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
    func textFieldShouldReturn(_ textField: UITextField)
    func didTapButton()
}

protocol RegisterNamePresenterOutput: AnyObject {
    func configureRegisterButton(enabled: Bool)
    func backToTopPage()
}

class RegisterNamePresenter: RegisterNamePresenterInput {
    
    var totalScore: Int
//    var rankingArray: [String] = []
    private var nameText: String?
    
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
    
    func textFieldShouldReturn(_ textField: UITextField) {
        
        if let textInput = textField.text, !textInput.isEmpty {
            view.configureRegisterButton(enabled: true)
        } else {
            view.configureRegisterButton(enabled: false)
        }
    }
    
    func didTapButton() {
        view.backToTopPage()
    }
}

extension RegisterNamePresenter {
    
}
