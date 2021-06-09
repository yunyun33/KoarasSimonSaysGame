//
//  MenuPresenter.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/09.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

protocol MenuPresenterInput {
    func didTapYunyunHp()
    func didTapPrivacyPolicy()
    func didTapNeetCheck()
    func didTapOuchiCafe()
}

protocol MenuPresenterOutput: AnyObject {
    
    func openSafariView(urlString: String)
}

class MenuPresenter: MenuPresenterInput {
    
    private weak var view: MenuPresenterOutput!
    
    init(view: MenuPresenterOutput) {
        self.view = view
    }
    
    func didTapYunyunHp() {
        view.openSafariView(urlString: CommonValue.URL.illustratorContactURL)
    }
    
    func didTapPrivacyPolicy() {
        view?.openSafariView(urlString: CommonValue.URL.privacyPolicyURL)
    }
    
    func didTapNeetCheck() {
        view.openSafariView(urlString: CommonValue.URL.neetCheckAppStorePage)
    }
    
    func didTapOuchiCafe() {
        view.openSafariView(urlString: CommonValue.URL.ouchiCafeAppAppStorePage)
    }
}
