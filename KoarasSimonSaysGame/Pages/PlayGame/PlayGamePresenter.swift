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
    func setFlagImage(Direction: Direction)
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
        view.setFlagImage(Direction: Direction.UP)
        
        if instructionDirection == Direction.UP {
            okCount += 1
            view.showGoodLabel()
            view.showNextInstruction()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapDown() {
        view.setFlagImage(Direction: Direction.DOWN)
        
        if instructionDirection == Direction.DOWN {
            okCount += 1
            view.showGoodLabel()
            view.showNextInstruction()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapRight() {
        view.setFlagImage(Direction: Direction.RIGHT)
        
        if instructionDirection == Direction.RIGHT {
            okCount += 1
            view.showGoodLabel()
            view.showNextInstruction()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapLeft() {
        view.setFlagImage(Direction: Direction.LEFT)
        
        if instructionDirection == Direction.LEFT {
            okCount += 1
            view.showGoodLabel()
            view.showNextInstruction()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
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
