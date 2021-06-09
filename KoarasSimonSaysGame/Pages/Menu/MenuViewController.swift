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
    
    // 開発者の連絡先(HP)
    let illustratorContactURL = "https://yunyun33.com/"
    //プライバシーポリシー
    let privacyPolicyURL = "https://yunyun33.com/koalasgame-privacy_policy/"
    //コアラさんのニート診断
    let neetCheckAppStorePage = "https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E3%83%8B%E3%83%BC%E3%83%88%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF/id1456451456?mt=8"
    //コアラさんのおうちカフェ
    let ouchiCafeAppAppStorePage =  "https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E3%81%8A%E3%81%86%E3%81%A1%E3%82%AB%E3%83%95%E3%82%A7/id1493333294?mt=8"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigationBarの戻るボタン押した時のイベントに必要
        navigationController?.delegate = self
        
        // ナビゲーションバーの透明化
        // 半透明の指定（デフォルト値）
        self.navigationController?.navigationBar.isTranslucent = true
        // 空の背景画像設定
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // ナビゲーションバーの影画像（境界線の画像）を空に設定
        self.navigationController!.navigationBar.shadowImage = UIImage()
    }
    
    @IBAction func onTapYunyun(_ sender: Any) {
         openSafariView(urlString: illustratorContactURL)
    }

    @IBAction func onTapPrivacyPolicy(_ sender: Any) {
         openSafariView(urlString: privacyPolicyURL)
    }
    
    @IBAction func onTapNeetCheck(_ sender: Any) {
         openSafariView(urlString: neetCheckAppStorePage)
    }
    
    @IBAction func onTapOuchiCafe(_ sender: Any) {
        openSafariView(urlString: ouchiCafeAppAppStorePage)
    }
    
    func openSafariView(urlString: String) {
        let safariVC = SFSafariViewController(url: NSURL(string: urlString)! as URL)
        present(safariVC, animated: true, completion: nil)
    }
    
    //navigationBarの戻るボタン押した時の処理
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ViewController {
            navigationController.navigationBar.isHidden = true
        }
    }
}
