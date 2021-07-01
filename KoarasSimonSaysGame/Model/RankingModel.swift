//
//  RankingModel.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/16.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation
import Firebase

protocol RankingModelProtocol {
    func saveToUserDefaults(name: String, score: Int)
    func seveToFirestore(name: String, score: Int)
    func getToUserDefaultsDatas() -> [[String]]
    func getToFirestoreDatas(success: @escaping (_ datas: [String]) -> Void, failure: @escaping (Error) -> Void)
    func deleteToUserDefaultsDatas()
}

class RankingModel: RankingModelProtocol {
    
    var defaultstore:Firestore!
    
    func saveToUserDefaults(name: String, score: Int) {
        // 保存するメモ情報を配列にする 0: 名前, 1: スコア
        let rankingToSave: [String] = [name, "\(score)"]
        
        // すでに保存されているメモがあれば追加して保存
        if var memo: [[String]] = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            
            memo.append(rankingToSave)
            
            //並び替え。同立の場合、最初にgameした人が上に表示される
            let memoSorted = memo.sorted(by: {Double($0[1])! > Double($1[1])!})
            
            UserDefaults.standard.set(memoSorted, forKey: "nameAndScore")
            
        } else {
            // 保存しているメモがなければ新規で保存
            UserDefaults.standard.set([rankingToSave], forKey: "nameAndScore")
        }
    }
    
    //データをFirestoreに保存
    func seveToFirestore(name: String, score: Int) {
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("users").addDocument(data: [
            "rankingName": name,
            "totalScore": score,
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    //UserDefaltsからデータ取得
    func getToUserDefaultsDatas() -> [[String]] {
        return UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] ?? [[]]
    }
    
    //Firestoreからデータ取得
    func getToFirestoreDatas(success: @escaping (_ datas: [String]) -> Void, failure: @escaping (Error) -> Void) {
        
        Firestore.firestore().collection("users").order(by: "totalScore", descending: true).getDocuments { (snaps, error) in
            if let error = error {
                failure(error)
            }
            
            guard let snaps = snaps else { return }
            for document in snaps.documents {
                
                let data = document.data()
                
                guard let rankingNameData:String = data["rankingName"] as? String else {
                    print("rankingName is nil")
                    return
                }
                guard let totalScoreData:Int = data["totalScore"] as? Int else {
                    print("totalScore is nil")
                    return
                }
                
                print("Name: \(rankingNameData)")
                print("Score: \(totalScoreData)")
                
                let firestoreData: [String] = [rankingNameData, "\(totalScoreData)"]
                success(firestoreData)
            }
        }
    }
    
    //UserDefaltsのデータ削除
    func deleteToUserDefaultsDatas() {
        UserDefaults.standard.removeObject(forKey: "nameAndScore")
    }
}
