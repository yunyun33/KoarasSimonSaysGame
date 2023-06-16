//
//  CommonValue.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2021/06/09.
//  Copyright © 2021 yuikonno. All rights reserved.
//

import Foundation

//画面間でデータを共有、参照するための構造体を定義

struct CommonValue {
    
    //ResultPageで表示するコアラさんからのメッセージ
    static let resultMessegeExcellent = "あ、あなたは何者ですか！？\n旗ふりの達人ですね！"
    static let resultMessegeAmazing = "す、すごい！\nあなたの弟子にしてください！"
    static let resultMessegeWonderful = "すごいですね！\nあなたは旗ふり名人です！"
    static let resultMessegeGreat = "パチパチパチ\nお上手ですね！"
    static let resultMessegeLittleMore = "もう少しでしたね\nもう一度やってみましょう！"
    static let resultMessegeSleep = "もしかして寝ていましたか？\n私も眠くなってきました..."
    
    struct AlertMessage {
        static let noDataToDelete = "削除するデータがありません。"
        
        static let failedGetData = "データの取得に失敗しました。"
    }
    
    struct URL {
        // 開発者の連絡先(HP)
        static let illustratorContactURL = "https://yunyun33.com/"
        
        //プライバシーポリシー
        static let privacyPolicyURL = "https://yunyun33.com/koalasgame-privacy_policy/"
        
        //コアラさんのニート診断
        static let neetCheckAppStorePage = "https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E3%83%8B%E3%83%BC%E3%83%88%E3%83%81%E3%82%A7%E3%83%83%E3%82%AF/id1456451456?mt=8"
        
        //コアラさんのおうちカフェ
        static let ouchiCafeAppAppStorePage =  "https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E3%81%8A%E3%81%86%E3%81%A1%E3%82%AB%E3%83%95%E3%82%A7/id1493333294?mt=8"
    }
}
