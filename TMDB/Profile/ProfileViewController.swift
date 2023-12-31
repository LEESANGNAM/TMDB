//
//  ProfileViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    let profileList = ProfileType.allCases
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpView() {
        super.setUpView()
    }
    override func setDelegate() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        cell.nameLabel.text = profileList[indexPath.row].text
        cell.contentLabel.text =  profileList[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = NameSettingViewController()
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        }else if indexPath.row == 1{
            let vc = UserIdSettingViewController()
            navigationController?.pushViewController(vc, animated: true)
            if let cell = mainView.tableView.cellForRow(at: indexPath) as? ProfileTableViewCell {
                vc.passIdDataHandler = {
                    cell.contentLabel.text = $0
                    cell.contentLabel.textColor = .black
                }
            }
        }
    }
}

extension ProfileViewController: DelegatePatternTestProtocol{
    func passNameData(name: String) {
        //선택한 셀 인덱스가져와서
        if let selectCellIndexPath = mainView.tableView.indexPathForSelectedRow{
            // 셀 인스턴스 찾아서 값넣기
            if let cell = mainView.tableView.cellForRow(at: selectCellIndexPath) as? ProfileTableViewCell {
                // 다른 방법이 더 좋을 것 같다.
                cell.contentLabel.text = name
                cell.contentLabel.textColor = .black
            }
        }
    }
}
