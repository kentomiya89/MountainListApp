//
//  MtContainerViewController.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/26.
//

import UIKit

class MtContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func tappedThumbup(_ sender: Any) {
        NotificationCenter.default.post(name: .tappedThumBup,
                                        object: nil)
    }
}
