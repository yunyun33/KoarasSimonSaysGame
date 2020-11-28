//
//  RankingDateViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/17.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class RankingDateViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var nameAndScore: [[String]] = []
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "ランキング"
        // ↑文字の色設定
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
    
    override func viewWillAppear(_ animated: Bool) {
               
        nameAndScore.removeAll()
               
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            //同立の場合、最初にgameした人が上に表示される
            nameAndScore = savedname.sorted(by: {Double($0[1])! > Double($1[1])!})
            print(nameAndScore)
        }
        tableView.reloadData()
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        alert()
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
    
    //ランキング削除ボタンが押された時のアラート
    func alert() {
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
    
    //navigationBarの戻るボタン押した時の処理
       func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
           if viewController is ViewController {
               //ホームでnavigationBarが出るのを防止
               navigationController.navigationBar.isHidden = true
           }
       }
}
