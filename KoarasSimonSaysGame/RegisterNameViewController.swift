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
    
    var totalScore: Int = 0
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
        // 保存するメモ情報を配列にする 0: 名前, 1: スコア
        let rankingToSave: [String] = [rankingName, "\(totalScore)"]
        // すでに保存されているメモがあれば追加して保存
        if var memo: [[String]] = UserDefaults.standard.array(forKey: "nameAndScore") as? [[String]] {
            memo.append(rankingToSave)
            UserDefaults.standard.set(memo, forKey: "nameAndScore")
        } else {
            // 保存しているメモがなければ新規で保存
            UserDefaults.standard.set([rankingToSave], forKey: "nameAndScore")
        }

        //登録するボタンを押してhomeへ戻る
        dismiss(animated: false, completion: nil)
        let navigationController = presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
        //TotalScoreViewControllerでnavigationcontorollerを消していたので、homeに戻る時に出す
        navigationController?.navigationBar.isHidden = false
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
