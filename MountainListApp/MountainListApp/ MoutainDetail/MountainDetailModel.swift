//
//  MountainDetailModel.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/25.
//

import Foundation

protocol MountainDetailModelInput {
    func mountainInfo() -> MountainInfo
    func recommendMountains() -> [MountainInfo]
    func selectedMountain(_ mountainId: Int)
}

final class MountainDetailModel: MountainDetailModelInput {
    private let shared = MtInfoCommonData.shared
    let notificationCenter = NotificationCenter.default

    init() {
        notificationCenter.addObserver(self,
                                       selector: #selector(changeIsLikeStatus),
                                       name: .tappedThumBup,
                                       object: nil)
    }

    func removeObserverInModel() {
        notificationCenter.removeObserver(self,
                                          name: .tappedThumBup,
                                          object: nil)
    }

    // 表示している山の情報
    func mountainInfo() -> MountainInfo {
        let mountainID = shared.selectedMtId
        let mountain = shared.mountains.filter { $0.id == mountainID }
        return mountain[0]
    }

    func selectedMountain(_ mountainId: Int) {
        shared.saveSelectedMountain(mountainId)
    }

    // おすすめの基準　同じエリア > 難易度 > ID　で優先して探す
    // 返す数が2個想定
    // 一つのオススメ基準で探して2個に満たなければ次の基準を探す
    func recommendMountains() -> [MountainInfo] {

        // 最初は同じエリアから探す
        var mtsInfo = searchSameAreaMountains()
        // 1回目のオススメで2つ見つければ返す
        if mtsInfo.count == 2 {
            return mtsInfo
        }

        // 2回目のオススメで難易度から探す
        mtsInfo = searchSameDifficultyLevelMt(with: mtsInfo)
        // 2回目のオススメで2つ見つければ返す
        if mtsInfo.count == 2 {
            return mtsInfo
        }

        // 1回目も2回目も満たす数が見つけれなければ
        // 異なるIDで最終的に返す
        return searchDifferentIDMt(with: mtsInfo)
    }

    @objc func changeIsLikeStatus() {
        let mountain = mountainInfo()
        shared.changeMtThumbupStatus(mountain: mountain)
    }
}

// MARK: 内部的なオススメアルゴリズム
extension MountainDetailModel {

    // 同じエリアでオススメを探す
    private func searchSameAreaMountains() -> [MountainInfo] {
        let mtInfo = mountainInfo()
        let sameAreaMts = shared.mountains
            .filter { $0.areaId == mtInfo.areaId && $0.id != mtInfo.id }

        if sameAreaMts.count < 3 {
            // 3個未満はそのまま返す
            return sameAreaMts
        } else {
            // 3個以上はランダムに2つ選んで返す
            return Array(sameAreaMts.shuffled().prefix(2))
        }
    }

    // 同じ難易度のを探す
    // 引数sameAreaMtsInfoは 0か1を想定
    private func searchSameDifficultyLevelMt(with sameAreaMtsInfo: [MountainInfo]) -> [MountainInfo] {

        let mtInfo = mountainInfo()
        var sameDiffcultMts = shared.mountains.filter { $0.difficultyLevel == mtInfo.difficultyLevel && $0.id != mtInfo.id }

        guard sameAreaMtsInfo.count != 0 else {
            if sameDiffcultMts.count < 3 {
                // 3個未満はそのまま返す
                return sameDiffcultMts
            } else {
                // 3個以上はランダムに2つ選んで返す
                return Array(sameDiffcultMts.shuffled().prefix(2))
            }
        }

        //　見つけたエリアの分を取り出す
        let sameAreaMt = sameAreaMtsInfo[0]

        if sameDiffcultMts.count < 2 {
            // 2個未満は足して返す
            sameDiffcultMts.append(sameAreaMt)
            return sameDiffcultMts
        } else {
            // 2個以上はランダムに1つ選んでマージして返す
            var mergeMts =  Array(sameDiffcultMts.shuffled().prefix(1))
            mergeMts.append(sameAreaMt)
            return mergeMts
        }
    }

    // 異なるIDから
    private func searchDifferentIDMt(with searchedMtsInfo: [MountainInfo]) -> [MountainInfo] {
        let mtInfo = mountainInfo()
        var diffMts = shared.mountains.filter { $0.id != mtInfo.id }

        // 一つなら
        if searchedMtsInfo.count == 1 {
            let searchedMt = searchedMtsInfo[0]
            diffMts = diffMts.filter { $0.id != searchedMt.id }

            var mergeMt = Array(diffMts.shuffled().prefix(1))
            mergeMt.append(searchedMt)
            return mergeMt
        } else {
            return Array(diffMts.shuffled().prefix(2))
        }
    }
}
