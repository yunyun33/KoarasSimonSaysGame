//
//  RankingDateViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/17.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
import Firebase

class RankingDataViewController: UIViewController {
    
    var presenter: RankingDataPresenterInput!
    
    @IBOutlet weak var garbageCanButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        presenter.viewDidLoad()
    }
    
    @IBAction func onTapDelete(_ sender: Any) {
        presenter.didTapDeleteButton()
    }
}

extension RankingDataViewController: UITableViewDelegate, UITableViewDataSource {
    
    //セルの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 60
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfNameAndScore()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rankingCell", for: indexPath) as! RankingCell
        
        let nameAndScore = presenter.nameAndScore(forRow: indexPath.row)
        
        cell.rankingNumberLabel.text = "\(indexPath.row + 1)位"
        cell.rankingNameLabel.text = "\(nameAndScore[0])"
        cell.rankingScoreLabel.text = "\(nameAndScore[1])点"
      
        return cell 
    }
}

extension RankingDataViewController: UINavigationControllerDelegate {
    //navigationBarの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        
        if viewController is ViewController {
            //ホームでnavigationBarが出るのを防止
            navigationController.navigationBar.isHidden = true
        }
    }
}

extension RankingDataViewController {

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
}

extension RankingDataViewController: RankingDataOutput {
    
    func setupWordRanking() {
        self.navigationItem.title = "World Ranking"
        garbageCanButton.isHidden = true
    }
    
    func setupLocalRanking() {
        self.navigationItem.title = "ランキング"
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
    //ランキング削除ボタンが押された時のアラート
    func showDeleteAlert() {
        let alert: UIAlertController = UIAlertController(title: "ランキングデータを\n削除します。",
                                                         message: "データは全て削除されます。",
                                                         preferredStyle: .alert)
        //OKボタン
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
                    (action:UIAlertAction!) -> Void in
            self.presenter.didTapOkOnDeleteAll()
        })
        alert.addAction(okAction)
        
        //キャンセルボタン
        let cancelAction: UIAlertAction = UIAlertAction(title: "キャンセル", style: .default) { (UIAlertAction) in
            // NOP
        }
        alert.addAction(cancelAction)
        
        //アラート画面を表示させる
        present(alert, animated: true, completion: nil)
    }
    
    func showOkAlert(alertMessage: String) {
        let alert: UIAlertController = UIAlertController(title: alertMessage,
                                                         message: "",
                                                         preferredStyle: .alert)
        
        //OKボタン
        let okAction: UIAlertAction = UIAlertAction(title: "OK", style: .default, handler:{
                    (action:UIAlertAction!) -> Void in
            // NOP
        })
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
    }
}
