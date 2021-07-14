![162AB86E-F1CB-4AEC-B372-88932E182E38_4_5005_c](https://user-images.githubusercontent.com/61610711/125634809-82dab47f-c8f7-407f-8b1d-f7c518e495c4.jpeg)

## アプリの概要
- App Storeに[「コアラさんの旗ふりゲーム」](https://apps.apple.com/jp/app/%E3%82%B3%E3%82%A2%E3%83%A9%E3%81%95%E3%82%93%E3%81%AE%E6%97%97%E6%8C%AF%E3%82%8A%E3%82%B2%E3%83%BC%E3%83%A0/id1518792012?mt=8)としてリリースしています。
- 指示された方向に旗をふる15秒間のミニゲームが楽しめるiOSアプリです。
- ゲームの得点を登録、表示できるランキング機能もあります。(ローカルランキング、世界ランキング)

## 開発環境
- macOS Big Sur 11.4
- xcode 12.5 で開発
- iOS Deployment Target 13.0

## データベース
- ゲーム得点の世界ランキングにおいて[Firebase Firestore](https://firebase.google.com/docs/firestore?hl=ja) を使用しています。

## アーキテクチャ
- MVPを採用しています。

## 補足
- Android版[「コアラさんの旗ふりゲーム」](https://github.com/yunyun33/KoalasSimonSaysGame_android)(Kotlin)も作成、リリースしています。
