//
//  RegisterNameViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/12.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
import Firebase

class RegisterNameViewController: UIViewController,UITextFieldDelegate {
    
    var presenter: RegisterNamePresenterInput!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    private var nameText: String?
    @IBOutlet weak var worldRankingSwith: UISwitch!
    @IBOutlet weak var joinTheWorldRankingLabel: UILabel!
    
    var totalScore: Int = 0
    var rankingArray: [String] = []
    var defaultstore:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = RegisterNamePresenter(totalScore: totalScore, view: self)
       
        nameTextField.delegate = self
        
        worldRankingSwith.isEnabled = false
        joinTheWorldRankingLabel.textColor = UIColor.lightGray
        
        worldRankingSwith.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
    }
   
    @IBAction func onTapRegisterButton(_ sender: Any) {
    
        guard let rankingName = nameTextField.text else {
            return
        }
        if nameTextField.text == "" {
            return
        }
        
        writeName()
    
        // 保存するメモ情報を配列にする 0: 名前, 1: スコア
        let rankingToSave: [String] = [rankingName, "\(totalScore)"]
        
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
        
        if worldRankingSwith.isOn {
            //データをFirestoreに保存
            var ref: DocumentReference? = nil
            ref = Firestore.firestore().collection("users").addDocument(data: [
                "rankingName": rankingName,
                "totalScore": self.totalScore,
            ]) { err in
                if let err = err {
                    print("Error adding document: \(err)")
                } else {
                    print("Document added with ID: \(ref!.documentID)")
                }
            }
        }
        //登録するボタンを押してhomeへ戻る
        self.dismiss(animated: false, completion: nil)
        let navigationController = self.presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func onTapDoNotRegisterButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        //↑まず消して、↓homeに遷移(戻る)
        let navigationController = presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func writeNameTextField(_ sender: Any) {
        self.nameText = (sender as AnyObject).text
        self.writeName()
    }

    //text打ち終わったらキーボードしまう
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        nameTextField.resignFirstResponder()
        return true
    }
    
    private func writeName() {
        //nillの場合は「登録する」ボタン押せない
        guard let nameText = self.nameText else {
            self.registerButton.isEnabled = false
            //worldRankingSwithは最初無効にしておく
            worldRankingSwith.isEnabled = false
            joinTheWorldRankingLabel.textColor = UIColor.lightGray
            return
        }
        //文字数が0の場合(""空文字)も「登録する」ボタン押せない
        if nameText.count == 0 {
            self.registerButton.isEnabled = false
            //worldRankingSwithは最初無効にしておく
            worldRankingSwith.isEnabled = false
            joinTheWorldRankingLabel.textColor = UIColor.lightGray
            return
        }
        // nilでないかつ0文字以上は「登録する」ボタン押せる、worldRankingSwithも有効になる
        self.registerButton.isEnabled = true
        worldRankingSwith.isEnabled = true
        joinTheWorldRankingLabel.textColor = UIColor.black
    }
}

extension RegisterNameViewController: RegisterNamePresenterOutput {
    
}
