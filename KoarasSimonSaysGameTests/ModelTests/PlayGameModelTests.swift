//
//  PlayGameModelTests.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2023/06/14.
//  Copyright © 2023 yuikonno. All rights reserved.
//

import XCTest
@testable import KoarasSimonSaysGameDEVELOP

class PlayGameModelTests: XCTestCase {

    let model = PlayGameModel()
    
    func testGetTotalScore() {
        
        let totalScore = model.getTotalScore(okCount: 5, ngCount: 2)
        XCTAssertEqual(totalScore, 3)
        
        let totalScore2 = model.getTotalScore(okCount: 5, ngCount: 8)
        XCTAssertEqual(totalScore2, 0)
    }
}
