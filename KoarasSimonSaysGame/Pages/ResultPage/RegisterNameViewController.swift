//
//  RegisterNameViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/12.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
import Firebase

class RegisterNameViewController: UIViewController {
    
    var presenter: RegisterNamePresenterInput!

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    private var nameText: String?
    @IBOutlet weak var worldRankingSwith: UISwitch!
    @IBOutlet weak var joinTheWorldRankingLabel: UILabel!
    
    var totalScore: Int = 0
//    var rankingArray: [String] = []
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
    
        presenter.didTapRegisterButton(nameText: nameTextField.text, worldRankingSwith: false)
    }
    
    @IBAction func onTapDoNotRegisterButton(_ sender: Any) {
        presenter.didTapDoNotRegisterButton()
    }
    
    @IBAction func writeNameTextField(_ sender: Any) {
        self.nameText = (sender as AnyObject).text
    }
}

extension RegisterNameViewController: UITextFieldDelegate {
    
    //text打ち終わったらキーボードしまう
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.textFieldShouldReturn(textField)
        nameTextField.resignFirstResponder()
        return true
    }
}

extension RegisterNameViewController: RegisterNamePresenterOutput {
    
    func configureRegisterButton(enabled: Bool) {
        
        if enabled {
            self.registerButton.isEnabled = true
            worldRankingSwith.isEnabled = true
            joinTheWorldRankingLabel.textColor = UIColor.black
            
        } else {
            self.registerButton.isEnabled = false
            worldRankingSwith.isEnabled = false
            joinTheWorldRankingLabel.textColor = UIColor.lightGray
        }
    }
    
    func backToTopPage() {
        self.dismiss(animated: false, completion: nil)
        let navigationController = self.presentingViewController as? UINavigationController
        navigationController?.popToRootViewController(animated: false)
    }
}
