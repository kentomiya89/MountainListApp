# MountainListApp
登山のアプリ

# 機能
* 山の一覧を表示
* 選択時、画面遷移して詳細画面で山の詳細な情報を表示
* 詳細画面でオススメの山を２つ表示(アルゴリズムは 同じエリア > 同じ難易度 > 異なるid　を基準にランダムで２つ山を表示する)
* オススメの山タップ時に画面遷移してその山の詳細な情報を表示
* いいね機能

## 山一覧画面
<img src="https://user-images.githubusercontent.com/26946838/105947947-709edc00-60ad-11eb-926a-d956712acd3d.png" width="200"> <img src="https://user-images.githubusercontent.com/26946838/105947959-77c5ea00-60ad-11eb-8594-445bfd08c663.png" width="200">


## 山詳細画面
<img src="https://user-images.githubusercontent.com/26946838/105947968-7b597100-60ad-11eb-8779-534714c31217.png" width="200"> <img src="https://user-images.githubusercontent.com/26946838/105947975-7f858e80-60ad-11eb-870f-37449189b32d.png" width="200">

# 動作環境
* iOS 13.0以上

# 環境
* Xcode 12
* Swift 5
* CocoaPods: 1.10.0
* Mint: 0.16.0

[CocoaPods](https://qiita.com/ShinokiRyosei/items/3090290cb72434852460)と[Mint](https://qiita.com/uhooi/items/6a41a623b13f6ef4ddf0)のインストールしていない場合は導入からお願いします。
 
 # 使用技術
 * UI: Stroyboard + XIB
 * Architecture: 
   * MVC
 * Library
   * CocoaPods
     * MaterialComponents/Buttons 120.0.0
     * PINRemoteImage 3.0.3
   * Swift Package Manager
     * Alamofire 5.4.1
 * Mint
   * SwiftGen 6.4.0
   * SwiftLint 0.42.0
