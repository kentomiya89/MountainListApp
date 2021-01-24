//
//  MountainListModel.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation

protocol MountainListModelInput {
    func fetchMountainInfo()
}

final class MountainListModel: MountainListModelInput {

    private let notificationCenter = NotificationCenter.default

    private(set) var mountains: [MountainInfo] = [] {
        didSet {
            notificationCenter.post(name: .fetchMountainInfo, object: nil)
        }
    }

    func fetchMountainInfo() {

        let moutainsAPI = YAMAPAPI.MoutainsList()

        APIClient().request(moutainsAPI) { [weak self] result in

            switch result {
            case .success(let response):
                self?.mountains = response
            case .failure: print("取得失敗")
            }
        }
    }
}
