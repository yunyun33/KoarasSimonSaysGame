//
//  ExtensionUIViewController.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/09.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    //画面遷移
    func transitionToNextPage(nextVC: UIViewController) {
        navigationController?.pushViewController(nextVC, animated: true)
        navigationController?.navigationBar.isHidden = false
    }
}
