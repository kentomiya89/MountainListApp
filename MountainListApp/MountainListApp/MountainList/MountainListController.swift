//
//  ViewController.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import UIKit

class MountainListController: UIViewController {

    private let notificationCenter = NotificationCenter.default

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.estimatedRowHeight = 124
            tableView.rowHeight = UITableView.automaticDimension
        }
    }

    var model: MountainListModel! {
        didSet {
            registerModel()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        model = MountainListModel()

        // setUp系
        setUpNotifications()
        setUpTableView()
    }

    func setUpNotifications() {
        notificationCenter.addObserver(self,
                                       selector: #selector(reloadData),
                                       name: .fetchMountainInfo,
                                       object: nil)
    }

    func setUpTableView() {
        tableView.register(UINib(nibName: NibFileName.mountainCell, bundle: nil), forCellReuseIdentifier: TableViewCellID.mountainCell)
    }
}

// MARK: Model関連の処理
extension MountainListController {

    func registerModel() {
        // 初回リクエスト
        model.fetchMountainInfo()
    }
}

extension MountainListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        model.mountains.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.mountainCell) as? MountainCell else { return UITableViewCell() }

        cell.configureContent(mountainInfo: model.mountains[indexPath.row])
        return cell
    }

    @objc func reloadData() {
        tableView.reloadData()
    }
}

extension MountainListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: StoryboardSegue.MountainList.showMountainDetail.rawValue, sender: nil)
    }
}

// MARK: Segue
extension MountainListController {

}
