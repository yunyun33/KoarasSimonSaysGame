//
//  RegisterNamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/16.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol RegisterNamePresenterInput {
    func didTapButton()
}

protocol RegisterNamePresenterOutput: AnyObject {
    func backToTopPage()
}

class RegisterNamePresenter: RegisterNamePresenterInput {
    
    var totalScore: Int
    
    private weak var view: RegisterNamePresenterOutput!
    
    init(totalScore: Int, view: RegisterNamePresenterOutput) {
        self.totalScore = totalScore
        self.view = view
    }
    
    func didTapButton() {
        view.backToTopPage()
    }
}
