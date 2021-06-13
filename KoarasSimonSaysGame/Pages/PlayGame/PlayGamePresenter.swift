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
    func startTimer()
    func didTapUp()
    func didTapDown()
    func didTapRight()
    func didTapLeft()
    func finishOfTimer()
    func playMusic()
    func stopTimerAndMusic()
}

protocol PlayGamePresenterOutput: AnyObject {
    func setupUI()
    func setCountDownLabel(timerCount: Int)
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
    
    //タイマー
    var timer : Timer?
    var timerCount = 15
    
    func viewDidLoad() {
        view.setupUI()
        startTimer()
        playMusic()
        proceedToNextDirection()
    }
    
    //時間経過の処理
    @objc func timerInterrupt(_ timer: Timer) {
        //経過時間に+1していく
        timerCount -= 1
        
        //残り時間をラベルに表示
        view.setCountDownLabel(timerCount: timerCount)
        
        //残り時間が0以下のとき、タイマーを止める
        if timerCount == 0 {
            //タイマー停止,停止と一緒に実行すること
            stopTimerAndMusic()
            finishOfTimer()
        }
    }
    
    func startTimer() {
        //タイマースタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
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
    
    func stopTimerAndMusic() {
        timer?.invalidate()
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
