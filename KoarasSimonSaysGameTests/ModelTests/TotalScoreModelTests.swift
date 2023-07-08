//
//  TotalScoreModelTests.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2023/06/15.
//  Copyright © 2023 yuikonno. All rights reserved.
//

import XCTest
@testable import KoarasSimonSaysGameDEVELOP

class TotalScoreModelTests: XCTestCase {

    let model = TotalScoreModel()

    func testGetKoalasMessage() {
        
        let message = model.getKoalasMessage(totalScore: 28)
        XCTAssertEqual(message, CommonValue.resultMessegeExcellent)
        
        let message2 = model.getKoalasMessage(totalScore: 25)
        XCTAssertEqual(message2, CommonValue.resultMessegeAmazing)
        
        let message3 = model.getKoalasMessage(totalScore: 21)
        XCTAssertEqual(message3, CommonValue.resultMessegeWonderful)
        
        let message4 = model.getKoalasMessage(totalScore: 16)
        XCTAssertEqual(message4, CommonValue.resultMessegeGreat)
        
        let message5 = model.getKoalasMessage(totalScore: 5)
        XCTAssertEqual(message5, CommonValue.resultMessegeLittleMore)
        
        let message6 = model.getKoalasMessage(totalScore: 0)
        XCTAssertEqual(message6, CommonValue.resultMessegeSleep)
    }
}
