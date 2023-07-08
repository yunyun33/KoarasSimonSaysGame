//
//  PlayGameModel.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2023/06/14.
//  Copyright © 2023 yuikonno. All rights reserved.
//

import Foundation

protocol PlayGameModelProtocol {
    func getTotalScore(okCount: Int, ngCount: Int) -> Int
}

class PlayGameModel: PlayGameModelProtocol {
    func getTotalScore(okCount: Int, ngCount: Int) -> Int {
        let totalScore = okCount - ngCount
        if ( totalScore < 0 ) {
            return 0
        }
        return totalScore
    }
}

class MockPlayGameModel: PlayGameModelProtocol {
    var totalScore: Int = 0
    func getTotalScore(okCount: Int, ngCount: Int) -> Int {
        return totalScore
    }
}
