//
//  RegisterNameViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/12.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class RegisterNameViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    private var nameText: String?
    
    var totalScore: String = ""
    var rankingArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        nameTextField.delegate = self
    }
   
    @IBAction func onTapRegisterButton(_ sender: Any) {
    
        guard let rankingName = nameTextField.text else {
            return
        }
        if nameTextField.text == "" {
            return
        }
        if var ranking: [String] = UserDefaults.standard.stringArray(forKey: "nameAndScore") {
            ranking.append(rankingName)
            UserDefaults.standard.set(ranking, forKey: "nameAndScore")
        } else {
            UserDefaults.standard.set([rankingName], forKey: "nameAndScore")
        }
        
        //登録するボタンを押してRankingDateViewへ遷移する
        //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view5") as! RankingDateViewController
        //画面遷移
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    
    @IBAction func onTapDoNotRegister(_ sender: Any) {
    //storyboardのインスタンス取得
        let storyboard: UIStoryboard = self.storyboard!
        //遷移先ViewControllerのインスタンス取得
        let nextView = storyboard.instantiateViewController(withIdentifier: "view1") as! ViewController
        //画面遷移
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    //UserDefaultsに保存できているか確認ボタン
    @IBAction func onTapTestButton(_ sender: Any) {
        let ranking = UserDefaults.standard.stringArray(forKey: "nameAndScore")
        
        print(ranking)
        
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
