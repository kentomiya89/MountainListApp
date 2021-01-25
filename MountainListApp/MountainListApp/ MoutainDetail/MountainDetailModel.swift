//
//  MountainDetailModel.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/25.
//

import Foundation

final class MountainDetailModel {
    private let shared = MtInfoCommonData.shared

    func mountainInfo() -> MountainInfo {
        let index = shared.selectedIndex
        return shared.mountains[index]
    }
}
