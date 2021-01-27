//
//  ViewController.swift
//  MountainListApp
//
//  Created by kentomiyabayashi on 2021/01/24.
//

import UIKit

class MountainListController: UIViewController {

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

    var moutainsInfo: [MountainInfo] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        model = MountainListModel()

        setUpTableView()
    }

    func setUpTableView() {
        tableView.register(UINib(nibName: NibFileName.mountainCell, bundle: nil), forCellReuseIdentifier: TableViewCellID.mountainCell)
    }
}

// MARK: Model関連の処理
extension MountainListController {

    func registerModel() {
        // 初回リクエスト
        model.fetchMountainInfo { [weak self] result in
            self?.moutainsInfo = result
            DispatchQueue.main.async {
                self?.reloadData()
            }
        }
        setUpNotifications()
    }

    func setUpNotifications() {
        model.notificationCenter.addObserver(self,
                                             selector: #selector(updateThumBupInCellView(notification:)),
                                             name: .changeMountainInfo,
                                             object: nil)
    }
}

extension MountainListController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        moutainsInfo.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCellID.mountainCell) as? MountainCell else { return UITableViewCell() }
        cell.delegate = self

        cell.configureContent(mountainInfo: moutainsInfo[indexPath.row])
        return cell
    }

    func reloadData() {
        tableView.reloadData()
    }

    @objc func updateThumBupInCellView(notification: Notification?) {

        guard let row = notification?.userInfo?[UserInfo.mountainsIndexKey] as? Int else { return }
        let indexPath = IndexPath(row: row, section: 0)

        moutainsInfo = model.fetchLatestData()
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

extension MountainListController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        model.selectMountainInfo(index: indexPath.row)

        performSegue(withIdentifier: StoryboardSegue.MountainList.showMountainDetail.rawValue,
                     sender: nil)
    }
}

extension MountainListController: MountainCellDelegate {

    func mountainCellDelegate(_ cell: MountainCell, didChangeThumbupStatus sender: Any) {

        guard let indexPath = tableView.indexPath(for: cell) else { return }
        model.changeThumBupStatus(indexPath.row)
    }
}
