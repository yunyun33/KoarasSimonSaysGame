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

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    private var nameText: String?
    @IBOutlet weak var worldRankingSwith: UISwitch!
    
    var totalScore: Int = 0
    var rankingArray: [String] = []
    var defaultstore:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameTextField.delegate = self
        
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
        let rankingToSaveDictionary: [String: String] = [rankingName: "\(totalScore)"]
        
        // すでに保存されているメモがあれば追加して保存
        if var memo: [[String]] = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            memo.append(rankingToSave)
            UserDefaults.standard.set(memo, forKey: "nameAndScore")
        } else {
            // 保存しているメモがなければ新規で保存
            UserDefaults.standard.set([rankingToSave], forKey: "nameAndScore")
        }
        
        if worldRankingSwith.isOn {
                Firestore.firestore().collection("users").getDocuments { (snaps, error) in
                    if let error = error {
                        fatalError("\(error)")
                    }
                    guard let snaps = snaps else { return }
                    for document in snaps.documents {
//                        print(document.data())
                        let data = document.data()
                        let rankingNameData: String = data["rankingName"] as! String
                        let totalScoreData:String = data["totalScore"] as! String
//                        print(rankingNameData)
                        
                        let rankingToSave: [String] = [rankingNameData, totalScoreData]
                        let rankingToSaveDictionary: [String: String] = [rankingNameData: totalScoreData]
                        
                        // すでに保存されているメモがあれば追加して保存
                        if var memo: [[String]] = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
                            memo.append(rankingToSave)
                            UserDefaults.standard.set(memo, forKey: "nameAndScore")
                        } else {
                            // 保存しているメモがなければ新規で保存
                            UserDefaults.standard.set([rankingToSave], forKey: "nameAndScore")
                        }
                    }
                }
        }

        //登録するボタンを押してhomeへ戻る
        dismiss(animated: false, completion: nil)
        let navigationController = presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
    
    @IBAction func onTapDoNotRegisterButton(_ sender: Any) {
        dismiss(animated: false, completion: nil)
        //↑まず消して、↓homeに遷移(戻る)
        let navigationController = presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
    
    private func writeName() {
        //nillの場合は「登録する」ボタン押せない
        guard let nameText = self.nameText else {
            self.registerButton.isEnabled = false
            return
        }
        //文字数が0の場合(""空文字)も「登録する」ボタン押せない
        if nameText.count == 0 {
            self.registerButton.isEnabled = false
            return
        }
        // nilでないかつ0文字以上は「登録する」ボタン押せる
          self.registerButton.isEnabled = true
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
}
