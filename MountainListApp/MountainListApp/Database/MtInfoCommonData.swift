//
//  MtInfoCommonData.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/25.
//

import Foundation

class MtInfoCommonData {

    private(set) var mountains: [MountainInfo] = []
    private(set) var selectedMtId: Int = 0

    static let shared = MtInfoCommonData()
    private init() {}

    func saveMountainsInfo(_ mountainInfo: [MountainInfo]) {
        self.mountains = mountainInfo
    }

    func saveSelectedMountain(_ mountainID: Int) {
        self.selectedMtId = mountainID
    }

    func changeMtThumbupStatus(mountain: MountainInfo) {
        var mountain = mountain
        // いいね有効だったら-1
        // いいね無効なら+1
        // する
        mountain.likeCount = mountain.isLike ?
            mountain.likeCount - 1 : mountain.likeCount + 1

        // 逆にする
        mountain.isLike = !mountain.isLike
        changeMountainInfo(mountain)
    }

    private func changeMountainInfo(_ mountain: MountainInfo) {

        if let index = mountains.firstIndex(of: mountain) {
            mountains[index] = mountain
            NotificationCenter.default.post(name: .changeMountainInfo,
                                            object: nil,
                                            userInfo: [UserInfo.mountainsIndexKey: index])
        }
    }
}
