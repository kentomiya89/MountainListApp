//
//  MountainCell.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import UIKit
import PINRemoteImage

class MountainCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var mountainName: UILabel!
    @IBOutlet weak var thumbupImage: UIImageView!
    @IBOutlet weak var thumbupLabel: UILabel!
    @IBOutlet weak var thumbupCount: UILabel!

    func configureContent(mountainInfo: MountainInfo) {
        mountainName.text = mountainInfo.name
        thumbupCount.text = String(mountainInfo.likeCount)
        thumbnail.pin_setImage(from: URL(string: mountainInfo.thumbnailUrl)!)

        // 色と画像
        thumbupImage.image = mountainInfo.isLike ? Asset.Image.thumbupOrange.image : Asset.Image.thumbup.image
        thumbupLabel.textColor = mountainInfo.isLike ? Asset.Color.thumBup.color : UIColor.label
        thumbupCount.textColor = mountainInfo.isLike ? Asset.Color.thumBup.color : UIColor.label
    }
}
