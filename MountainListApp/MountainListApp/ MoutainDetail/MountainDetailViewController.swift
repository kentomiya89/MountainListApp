//
//  MountainDetailViewController.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/25.
//

import UIKit
import PINRemoteImage

class MountainDetailViewController: UIViewController {

    @IBOutlet weak var mountainImage: UIImageView!
    @IBOutlet weak var mountainName: UILabel!
    @IBOutlet weak var prefectures: UILabel!
    @IBOutlet weak var elevation: UILabel!
    @IBOutlet weak var thumbupCount: UILabel!
    @IBOutlet weak var descriptionMt: UILabel!

    @IBOutlet weak var recommendMtImage1: UIImageView!
    @IBOutlet weak var recommendMtName1: UILabel!

    @IBOutlet weak var recommendMtImage2: UIImageView!
    @IBOutlet weak var recommendMtName2: UILabel!

    var model: MountainDetailModel!
    var recommendMountains: [MountainInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        model = MountainDetailModel()

        configMountainInfo()
    }

    func configMountainInfo() {
        let mountainInfo = model.mountainInfo()
        mountainImage.pin_setImage(from: URL(string: mountainInfo.imageUrl)!)
        mountainName.text = mountainInfo.name
        elevation.text = String(mountainInfo.elevation) + L10n.meter
        thumbupCount.text = String(mountainInfo.likeCount)
        prefectures.text = mountainInfo.prefectures.joined(separator: "/")
        descriptionMt.text = mountainInfo.description

        showRecommendMt()
    }

    private func showRecommendMt() {
        recommendMountains = model.recommendMountains()

        // 一つ目
        let firstMountain = recommendMountains[0]
        recommendMtImage1.pin_setImage(from: URL(string: firstMountain.imageUrl)!)
        recommendMtName1.text = firstMountain.name

        let secondMountain = recommendMountains[1]
        recommendMtImage2.pin_setImage(from: URL(string: secondMountain.imageUrl)!)
        recommendMtName2.text = secondMountain.name
    }

    @IBAction func tapRecommendMt1(_ sender: Any) {
        transion(recommendMountains[0])
    }

    @IBAction func tapRecommendMt2(_ sender: Any) {
        transion(recommendMountains[1])
    }

    func transion(_ mountain: MountainInfo) {
        // 山のIDを保存
        model.selectedMountain(mountain.id)
        navigationController?.pushViewController(StoryboardScene.MountainDetail.initialScene.instantiate(),
                                                 animated: true)
    }
}
