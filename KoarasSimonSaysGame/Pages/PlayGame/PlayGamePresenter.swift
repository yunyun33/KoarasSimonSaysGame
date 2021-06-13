//
//  PlayGamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayGamePresenterInput {
    func viewDidLoad()
    func didTapUp()
    func didTapDown()
    func didTapRight()
    func didTapLeft()
    func finishOfTimer()
    func playMusic()
    func stopTheMusic()
}

protocol PlayGamePresenterOutput: AnyObject {
    func setupUI()
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
    var instructionDirection: Direction = .UP
    //正解カウント
    var okCount: Int = 0
    //不正解カウント
    var ngCount: Int = 0
    var totalScore: Int = 0
    
    //audioPlayerのインスタンス生成
    var audioPlayer : AVAudioPlayer!
    
    func viewDidLoad() {
        view.setupUI()
        playMusic()
        proceedToNextDirection()
    }
    
    func didTapUp() {
        view.setFlagImage(direction: .UP)
        
        if instructionDirection == .UP {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapDown() {
        view.setFlagImage(direction: .DOWN)
        
        if instructionDirection == .DOWN {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapRight() {
        view.setFlagImage(direction: .RIGHT)
        
        if instructionDirection == .RIGHT {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    func didTapLeft() {
        view.setFlagImage(direction: .LEFT)
        
        if instructionDirection == .LEFT {
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
    
    //BGMの設定、再生
    func playMusic() {

        do {
            let filePath = Bundle.main.path(forResource: "playBGM",ofType: "mp3")
            let music = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: music)
        } catch {
            print("error")
        }
        audioPlayer.play()
    }
    
    func stopTheMusic() {
        audioPlayer.stop()
    }
}

extension PlayGamePresenter {
    
    //次の方向指示をランダムで表示させる
    private func proceedToNextDirection() {
        
        instructionDirection = Direction.allCases.randomElement()!
        view.showNextInstruction(direction: instructionDirection)
    }
}
