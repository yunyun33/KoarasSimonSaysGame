//
//  RankingUseCase.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2022/09/30.
//  Copyright © 2022 yuikonno. All rights reserved.
//

import Foundation

class RankingUseCase {
    private let rankingModel: RankingModel
    
    init(rankingModel: RankingModel) {
        self.rankingModel = rankingModel
    }
    
    // UserDefaultsに保存する
    func saveRankingToUserDefaults(name: String, score: Int) {
        rankingModel.saveToUserDefaults(name: name, score: score)
    }
    
    // データをFirestoreに保存
    func seveRankingToFirestore(name: String, score: Int) {
        rankingModel.seveToFirestore(name: name, score: score)
    }
    
    // UserDefaltsからデータ取得
    func getRankingUserDefaultsDatas() -> [[String]] {
        return rankingModel.getUserDefaultsDatas()
    }
    
    // Firestoreからデータ取得
    func getRankingFirestoreDatas(success: @escaping (_ datas: [[String]]) -> Void, failure: @escaping (Error) -> Void) {
        
        rankingModel.getFirestoreDatas(success: { (firestoreDatas) in
            success(firestoreDatas)
            
        }, failure: { (Error) in
            failure(Error)
        })
    }
    
    // UserDefaltsのデータ削除
    func deleteRankingUserDefaultsDatas() {
        rankingModel.deleteUserDefaultsDatas()
    }
}
