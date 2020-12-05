//
//  RankingDateViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/17.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
import Firebase

class RankingDateViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var garbageCanButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    private var nameAndScore: [[String]] = []
    
    var isWorldRanking = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        if isWorldRanking == true {
            self.navigationItem.title = "World Ranking"
            garbageCanButton.isHidden = true
            garbageCanButton.isEnabled = true
            getFirestoreDatas()
        } else {
            self.navigationItem.title = "ランキング"
            getUserDefaultsDatas()
        }
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        showAlert()
    }
}

extension RankingDateViewController: UITableViewDelegate, UITableViewDataSource {
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAndScore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath) as! RankingCell
        
        cell.rankingNumberLabel.text = "\(indexPath.row + 1)位"
        cell.rankingNameLabel.text = "\(nameAndScore[indexPath.row][0])"
        cell.rankingScoreLabel.text = "\(nameAndScore[indexPath.row][1])点"
      
        return cell 
    }
    
    //navigationBarの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            //ホームでnavigationBarが出るのを防止
            navigationController.navigationBar.isHidden = true
        }
    }
    
    private func setupView() {
        // タイトルの文字の色設定
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(red: 89/225, green: 107/225, blue: 179/225, alpha: 1)]
        
        // ナビゲーションバーの透明化
        // 半透明の指定（デフォルト値）
        self.navigationController?.navigationBar.isTranslucent = true
        // 空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        //カスタムセルと紐づける
        tableView.register(UINib(nibName: "RankingCell", bundle: nil), forCellReuseIdentifier: "rankingCell")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //navigationBarの戻るボタン押した時のイベントに必要
        navigationController?.delegate = self
    }
    
    private func getUserDefaultsDatas() {
               
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            nameAndScore = savedname
        }
        tableView.reloadData()
    }
    
    //Firestoreにあるデータを取得する
    private func getFirestoreDatas() {
        
        Firestore.firestore().collection("users").order(by: "totalScore", descending: true).getDocuments { (snaps, error) in
            if let error = error {
                fatalError("\(error)")
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
                
                self.nameAndScore.append([rankingNameData, "\(totalScoreData)"])
            }
            self.tableView.reloadData()
        }
    }
    
    //ランキング削除ボタンが押された時のアラート
    private func showAlert() {
        let alert: UIAlertController = UIAlertController(title: "ランキングデータを\n削除します。",
                                                         message: "データは全て削除されます。",
                                                         preferredStyle: .alert)
        //OKボタン
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
                    (action:UIAlertAction!) -> Void in
            //OKボタン押されたらUserDefaltsのデータ削除
            UserDefaults.standard.removeObject(forKey: "nameAndScore")
            //↑のだけだとボタン押した瞬間は画面に表示されたままのため↓で表示を消す
            self.nameAndScore.removeAll()
            self.tableView.reloadData()
        })
        alert.addAction(okAction)
        
        //キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default) { (UIAlertAction) in }
        alert.addAction(cancelAction)
        
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
        return
    }
}
