//
//  RankingDateViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/17.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class RankingDateViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var nameAndScore: [[String]] = []
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
               
        nameAndScore.removeAll()
               
        if let savedname = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            nameAndScore = savedname
            print(nameAndScore)
        }
        tableView.reloadData()
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        alert()
    }
    
}

extension RankingDateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameAndScore.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //同立の場合、最初にgameした人が上に表示される
        let sortedRankingDate = nameAndScore.sorted(by: {Double($0[1])! > Double($1[1])!})
        
        var ranking = sortedRankingDate[indexPath.row]
        //indexPath.row+1　で左側に1,2,3と表示される
        cell.textLabel?.text = "\(indexPath.row + 1) \(ranking) "
      
        return cell ?? UITableViewCell()
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
            self.nameAndScore = []
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
