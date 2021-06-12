//
//  PlayGamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol PlayGamePresenterInput {
    func viewDidLoad()
    func didTapUp()
    func didTapDown()
    func didTapRight()
    func didTapLeft()
    func setNextInstruction() -> Direction
    func finishOfTimer()
}

protocol PlayGamePresenterOutput: AnyObject {
    func setupUI()
    func setMusic()
    func showGoodLabel()
    func showMissLabel()
    func showNextInstruction()
    func setFlagImage(tappedButton: Direction)
    func transitToTotalScorePage(score: Int)
}

class PlayGamePresenter: PlayGamePresenterInput {
    
    private weak var view: PlayGamePresenterOutput!
    
    init(view: PlayGamePresenterOutput) {
        self.view = view
    }
    
    //仮に初期値としてUPを入れる
    var instructionDirection: Direction = Direction.UP
    //正解カウント
    var okCount: Int = 0
    //不正解カウント
    var ngCount: Int = 0
    var totalScore: Int = 0
    
    func viewDidLoad() {
        view.setupUI()
        view.setMusic()
    }
    
    func didTapUp() {
        if instructionDirection == Direction.UP {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.setFlagImage(tappedButton: Direction.UP)
        view.showNextInstruction()
    }
    
    func didTapDown() {
        if instructionDirection == Direction.DOWN {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.setFlagImage(tappedButton: Direction.DOWN)
        view.showNextInstruction()
    }
    
    func didTapRight() {
        if instructionDirection == Direction.RIGHT {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.setFlagImage(tappedButton: Direction.RIGHT)
        view.showNextInstruction()
    }
    
    func didTapLeft() {
        if instructionDirection == Direction.LEFT {
            okCount += 1
            view.showGoodLabel()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
        view.setFlagImage(tappedButton: Direction.LEFT)
        view.showNextInstruction()
    }
    
    func setNextInstruction() -> Direction {
        instructionDirection = Direction.allCases.randomElement()!
        return instructionDirection
    }
    
    func finishOfTimer() {
        totalScore = okCount - ngCount
        if ( totalScore < 0 ) {
            totalScore = 0
        }
        view.transitToTotalScorePage(score: totalScore)
    }
}
