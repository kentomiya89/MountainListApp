//
//  MtInfoCommonData.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/25.
//

import Foundation

class MtInfoCommonData {

    private(set) var mountains: [MountainInfo] = []
    private(set) var selectedIndex: Int = 0

    static let shared = MtInfoCommonData()
    private init() {}

    func saveMountainsInfo(_ mountainInfo: [MountainInfo]) {
        self.mountains = mountainInfo
    }

    func saveSelectedIndex(_ index: Int) {
        self.selectedIndex = index
    }
}
