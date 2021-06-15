//
//  PlayGamePresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/10.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

protocol PlayGamePresenterInput {
    func viewDidLoad()
    func didTapDirectionButton(tappedDirection: Direction)
    func didTapBackButton()
}

protocol PlayGamePresenterOutput: AnyObject {
    func setupUI()
    func setCountDownLabel(timerCount: Int)
    func showGoodLabel()
    func showMissLabel()
    func showNextInstruction(direction: Direction)
    func setFlagImage(direction: Direction)
    func transitToTotalScorePage(score: Int, presenter: TotalScorePresenter)
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
    
    //ゲームの正解、不正解の判定
    func didTapDirectionButton(tappedDirection: Direction) {
        view.setFlagImage(direction: tappedDirection)
        
        if instructionDirection == tappedDirection {
            okCount += 1
            view.showGoodLabel()
            proceedToNextDirection()
        } else {
            ngCount += 1
            view.showMissLabel()
        }
    }
    
    //タイマー停止,BGM停止
    func didTapBackButton() {
        stopTimerAndMusic()
    }
}

extension PlayGamePresenter {

    //時間経過の処理
    @objc func timerInterrupt(_ timer: Timer) {
        //経過時間を−1ずつする。
        timerCount -= 1
        
        //残り時間をラベルに表示
        view.setCountDownLabel(timerCount: timerCount)
        
        //残り時間が0以下のとき、タイマーを止める
        if timerCount == 0 {
            //タイマー停止
            stopTimerAndMusic()
            finishOfTimer()
        }
    }
    
    private func startTimer() {
        //タイマースタート
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(self.timerInterrupt(_:)),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    //タイマーが終了した時に行う処理
    private func finishOfTimer() {
        totalScore = okCount - ngCount
        if ( totalScore < 0 ) {
            totalScore = 0
        }
        let totalScoreVC = UIStoryboard(name: "TotalScore", bundle: nil)
        let nextView = totalScoreVC.instantiateViewController(withIdentifier: "totalScoreView") as! TotalScoreViewController
        let presenter = TotalScorePresenter(totalScore: totalScore, view: nextView)
        view.transitToTotalScorePage(score: totalScore, presenter: presenter)
    }
    
    //BGMの設定、再生
    private func playMusic() {

        do {
            let filePath = Bundle.main.path(forResource: "playBGM",ofType: "mp3")
            let music = URL(fileURLWithPath: filePath!)
            audioPlayer = try AVAudioPlayer(contentsOf: music)
        } catch {
            print("error")
        }
        audioPlayer.play()
    }
    
    //タイマー停止,BGM停止
    private func stopTimerAndMusic() {
        timer?.invalidate()
        audioPlayer.stop()
    }

    //次の方向指示をランダムで表示させる
    private func proceedToNextDirection() {
        
        instructionDirection = Direction.allCases.randomElement()!
        view.showNextInstruction(direction: instructionDirection)
    }
}
