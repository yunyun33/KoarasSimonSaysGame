//
//  TotalScorePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/14.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol TotalScorePresenterInput {
    
}

protocol TotalScorePresenterOutput: AnyObject {
    
}

class TotalScorePresenter: TotalScorePresenterInput {
    
    private weak var view: TotalScorePresenterOutput!
    
    init(view: TotalScorePresenterOutput) {
        self.view = view
    }
}
