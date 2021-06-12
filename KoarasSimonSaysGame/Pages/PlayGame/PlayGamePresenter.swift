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
    func finishOfTimer()
}

protocol PlayGamePresenterOutput: AnyObject {
    func setupUI()
    func setMusic()
    func showGoodLabel()
    func showMissLabel()
    func showNextInstruction(direction: Direction)
    func setFlagImage(direction: Direction)
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
        proceedToNextDirection()
    }
    
    func didTapUp() {
        view.setFlagImage(direction: Direction.UP)
        
        if instructionDirection == Direction.UP {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapDown() {
        view.setFlagImage(direction: Direction.DOWN)
        
        if instructionDirection == Direction.DOWN {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapRight() {
        view.setFlagImage(direction: Direction.RIGHT)
        
        if instructionDirection == Direction.RIGHT {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapLeft() {
        view.setFlagImage(direction: Direction.LEFT)
        
        if instructionDirection == Direction.LEFT {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func finishOfTimer() {
        totalScore = okCount - ngCount
        if ( totalScore < 0 ) {
            totalScore = 0
        }
        view.transitToTotalScorePage(score: totalScore)
    }
}

extension PlayGamePresenter {
    
    private func proceedToNextDirection() {
        
        instructionDirection = Direction.allCases.randomElement()!
        view.showNextInstruction(direction: instructionDirection)
    }
}
