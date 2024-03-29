//
//  RegisterNameViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/04/12.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit

class RegisterNameViewController: UIViewController {
    
    var presenter: RegisterNamePresenterInput!
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var worldRankingSwith: UISwitch!
    @IBOutlet weak var joinTheWorldRankingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextField.delegate = self
        // 画面のどこかをタップでTextFiledを閉じる
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        worldRankingSwith.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        
        presenter.viewDidLoad()
    }
    
    @IBAction func onTapRegisterButton(_ sender: Any) {
        presenter.didTapRegisterButton(nameText: nameTextField.text, worldRankingSwith: worldRankingSwith.isOn)
    }
    
    @IBAction func onTapDoNotRegisterButton(_ sender: Any) {
        presenter.didTapDoNotRegisterButton()
    }
}

extension RegisterNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        presenter.textFieldShouldReturn(textField)
        return true
    }
    
    @objc func closeKeyboard() {
        presenter.textFieldShouldReturn(nameTextField)
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
