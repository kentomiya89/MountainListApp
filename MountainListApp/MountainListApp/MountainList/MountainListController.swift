//
//  ViewController.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import UIKit

class MountainListController: UIViewController {

    @IBOutlet weak var tableVIew: UITableView!

    var model: MountainListModel! {
        didSet {
            registerModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model = MountainListModel()
    }
}

// MARK: Model関連の処理
extension MountainListController {

    func registerModel() {
        // 初回リクエスト
        model.fetchMountainInfo()
    }
}
