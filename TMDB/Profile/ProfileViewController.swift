//
//  ProfileViewController.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/29.
//

import UIKit

class ProfileViewController: BaseViewController {
    
    let mainView = ProfileView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func setUpView() {
        view.backgroundColor = .white
    }
    override func setDelegate() {
        mainView.tableView.delegate = self
        mainView.tableView.dataSource = self
    }
}



extension ProfileViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = mainView.tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier) as? ProfileTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = NameSettingViewController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ProfileViewController: DelegatePatternTestProtocol{
    func passNameData(name: String) {
        //선택한 셀 인덱스가져와서
        if let selectCellIndexPath = mainView.tableView.indexPathForSelectedRow{
            // 셀 인스턴스 찾아서 값넣기
            if let cell = mainView.tableView.cellForRow(at: selectCellIndexPath) as? ProfileTableViewCell {
                // 다른 방법이 더 좋을 것 같다.
                cell.contentTextField.text = name
            }
        }
    }
}
