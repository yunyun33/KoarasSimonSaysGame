# KoarasSimonSaysGame

## アプリの概要
- iOSアプリ
- 指示された方向に旗をふる15秒間のミニゲームです。
- ランキング機能もあります。(ローカルランキング、世界ランキング)
- App Storeに[「コアラさんの旗ふりゲーム」](https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E6%97%97%E6%8C%AF%E3%82%8A%E3%82%B2%E3%83%BC%E3%83%A0/id1518792012?mt=8)をリリースしています。
- Android版[「コアラさんの旗ふりゲーム」](https://github.com/yunyun33/KoalasSimonSaysGame_android)(Kotlin)も作成。

## 開発環境
- macOS Big Sur 11.4
- xcode 12.5 で開発
- iOS Deployment Target 13.0

## データベース
- ゲーム得点の世界ランキングにおいて[Firebase Firestore](https://firebase.google.com/docs/firestore?hl=ja) を使用しています。

## アーキテクチャ
- MVPを採用しています。
