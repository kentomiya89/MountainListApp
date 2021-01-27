//
//  MountainCell.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import UIKit
import PINRemoteImage

protocol MountainCellDelegate: AnyObject {
    func mountainCellDelegate(_ cell: MountainCell, didChangeThumbupStatus sender: Any)
}

class MountainCell: UITableViewCell {
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var mountainName: UILabel!
    @IBOutlet weak var thumbupImage: UIButton!
    @IBOutlet weak var thumbupLabel: UILabel!
    @IBOutlet weak var thumbupCount: UILabel!

    weak var delegate: MountainCellDelegate?

    func configureContent(mountainInfo: MountainInfo) {
        mountainName.text = mountainInfo.name
        thumbupCount.text = String(mountainInfo.likeCount)
        thumbnail.pin_setImage(from: URL(string: mountainInfo.thumbnailUrl)!)

        // 色と画像
        let image = mountainInfo.isLike ? Asset.Image.thumbupOrange.image : Asset.Image.thumbup.image
        thumbupImage.setBackgroundImage(image, for: .normal)
        thumbupLabel.textColor = mountainInfo.isLike ? Asset.Color.thumBup.color : UIColor.label
        thumbupCount.textColor = mountainInfo.isLike ? Asset.Color.thumBup.color : UIColor.label
    }

    @IBAction func tappedThumBup(_ sender: Any) {
        delegate?.mountainCellDelegate(self, didChangeThumbupStatus: sender)
    }

}
