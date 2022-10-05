//
//  RegisterNamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/16.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import UIKit

protocol RegisterNamePresenterInput {
    func viewDidLoad()
    func didTapRegisterButton(nameText: String?, worldRankingSwith: Bool)
    func textFieldShouldReturn(_ textField: UITextField)
    func didTapDoNotRegisterButton()
}

protocol RegisterNamePresenterOutput: AnyObject {
    func configureRegisterButton(enabled: Bool)
    func backToTopPage()
}

class RegisterNamePresenter: RegisterNamePresenterInput {
    
    var totalScore: Int
    
    private weak var view: RegisterNamePresenterOutput!
    private let rankingUseCase: RankingUseCase
    
    init(totalScore: Int, view: RegisterNamePresenterOutput, rankingUseCase: RankingUseCase) {
        self.totalScore = totalScore
        self.view = view
        self.rankingUseCase = rankingUseCase
    }
    
    func viewDidLoad() {
        view.configureRegisterButton(enabled: false)
    }
    
    func didTapRegisterButton(nameText: String?, worldRankingSwith: Bool) {
        
        rankingUseCase.saveRankingToUserDefaults(name: nameText ?? "", score: totalScore)
        
        if worldRankingSwith == true {
            rankingUseCase.seveRankingToFirestore(name: nameText ?? "", score: totalScore)
        }
        
        //登録するボタンを押してTopへ戻る
        view.backToTopPage()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) {
        
        //キーボードをしまう
        textField.resignFirstResponder()
        
        if let textInput = textField.text, !textInput.isEmpty {
            view.configureRegisterButton(enabled: true)
        } else {
            view.configureRegisterButton(enabled: false)
        }
    }
    
    func didTapDoNotRegisterButton() {
        view.backToTopPage()
    }
}
