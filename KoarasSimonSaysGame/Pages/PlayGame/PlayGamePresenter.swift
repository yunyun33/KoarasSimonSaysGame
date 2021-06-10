//
//  PlayGamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol PlayGamePresenterInput {
    func didTapUp()
    func didTapDown()
    func didTapRight()
    func didTapLeft()
}

protocol PlayGamePresenterOutput: AnyObject {
    func showGoodLabel()
    func showMissLabel()
//    func showNextInstructionText()
    func showNextInstruction(tappedString: String)
}

class PlayGamePresenter: PlayGamePresenterInput {
    
    private weak var view: PlayGamePresenterOutput!
    
    init(view: PlayGamePresenterOutput) {
        self.view = view
    }
    
    //仮に初期値としてUPを入れる
    var instructionDirection = Direction.UP
    //正解カウント
    var okCount: Int = 0
    //不正解カウント
    var ngCount: Int = 0
    var totalCount: Int = 0
    
    func didTapUp() {
        if instructionDirection == Direction.UP {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.showNextInstruction(tappedString: CommonValue.instructionText[0])
    }
    
    func didTapDown() {
        if instructionDirection == Direction.DOWN {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.showNextInstruction(tappedString: CommonValue.instructionText[1])
    }
    
    func didTapRight() {
        if instructionDirection == Direction.RIGHT {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.showNextInstruction(tappedString: CommonValue.instructionText[2])
    }
    
    func didTapLeft() {
        if instructionDirection == Direction.LEFT {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.showNextInstruction(tappedString: CommonValue.instructionText[3])
    }
}
