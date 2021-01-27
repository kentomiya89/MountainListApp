//
//  MountainListModel.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import Foundation

protocol MountainListModelInput {
    func fetchMountainInfo(completionHandler: @escaping([MountainInfo]) -> Void)
    func fetchLatestData() -> [MountainInfo]
    func selectMountainInfo(index: Int)
    func changeThumBupStatus(_ index: Int)
}

final class MountainListModel: MountainListModelInput {

    let notificationCenter = NotificationCenter.default
    private let shared = MtInfoCommonData.shared

    func fetchMountainInfo(completionHandler: @escaping([MountainInfo]) -> Void) {

        let moutainsAPI = YAMAPAPI.MoutainsList()

        APIClient().request(moutainsAPI) { [weak self] result in
            switch result {
            case .success(let response):
                completionHandler(response)
                // マスターデータの方にも保存
                self?.shared.saveMountainsInfo(response)
            case .failure: print("取得失敗")
            }
        }
    }

    func selectMountainInfo(index: Int) {
        let mountain = shared.mountains[index]
        shared.saveSelectedMountain(mountain.id)
    }

    func changeThumBupStatus(_ index: Int) {
        let mountain = shared.mountains[index]
        shared.changeMtThumbupStatus(mountain: mountain)
    }

    func fetchLatestData() -> [MountainInfo] {
        return shared.mountains
    }
}
