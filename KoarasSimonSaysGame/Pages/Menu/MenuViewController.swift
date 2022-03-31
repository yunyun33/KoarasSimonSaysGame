//
//  MenuViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/06/14.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
import SafariServices

class MenuViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var versionLabel: UILabel!
    
    private var presenter: MenuPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = MenuPresenter(view: self)
        
        //navigationBarの戻るボタン押した時のイベントに必要
        navigationController?.delegate = self
        
        // ナビゲーションバーの透明化
        // 半透明の指定（デフォルト値）
        self.navigationController?.navigationBar.isTranslucent = true
        // 空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        // versionの番号を表示
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        versionLabel.text = "version \(version)"
    }
    
    @IBAction func onTapYunyun(_ sender: Any) {
        presenter.didTapYunyunHp()
    }

    @IBAction func onTapPrivacyPolicy(_ sender: Any) {
        presenter.didTapPrivacyPolicy()
    }
    
    @IBAction func onTapNeetCheck(_ sender: Any) {
        presenter.didTapNeetCheck()
    }
    
    @IBAction func onTapOuchiCafe(_ sender: Any) {
        presenter.didTapOuchiCafe()
    }
    
    //navigationBarの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            navigationController.navigationBar.isHidden = true
        }
    }
}

extension MenuViewController: MenuPresenterOutput {
    func openSafariView(urlString: String) {
        let safariVC = SFSafariViewController(url: NSURL(string: urlString)! as URL)
            present(safariVC, animated: true, completion: nil)
    }
}
