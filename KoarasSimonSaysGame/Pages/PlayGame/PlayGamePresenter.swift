//
//  PlayGamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol PlayGamePresenterInput {
    
}

protocol PlayGamePresenterOutput: AnyObject {
    
}

class PlayGamePresenter: PlayGamePresenterInput {
    
    private weak var view: PlayGamePresenterOutput!
    
    init(view: PlayGamePresenterOutput) {
        self.view = view
    }
}
