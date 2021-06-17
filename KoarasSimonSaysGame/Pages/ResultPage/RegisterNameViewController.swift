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
//    var defaultstore:Firestore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
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
    
        presenter.didTapRegisterButton(nameText: nameTextField.text, worldRankingSwith: worldRankingSwith.isEnabled)
        
        //登録するボタンを押してTopへ戻る
        presenter.didTapButton()
    }
    
    @IBAction func onTapDoNotRegisterButton(_ sender: Any) {
        presenter.didTapButton()
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
    
    func backToTopPage() {
        self.dismiss(animated: false, completion: nil)
        let navigationController = self.presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
}
