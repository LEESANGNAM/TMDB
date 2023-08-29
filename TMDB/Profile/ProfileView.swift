//
//  ProfileView.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/29.
//

import UIKit

class ProfileView: BaseView{
    
    lazy var viewList = [profileImageView,profileSettingButton,tableView,professionalButton,personalSettingButton]
    
    let profileImageView = {
       let imageView = UIImageView()
        imageView.backgroundColor = .systemRed
        return imageView
    }()
    let profileSettingButton = {
       let button = UIButton()
        button.setTitle("사진 또는 아바타 수정", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()
    let tableView = {
        let view = UITableView()
        view.register(ProfileTableViewCell.self, forCellReuseIdentifier: ProfileTableViewCell.identifier)
        view.separatorInset = UIEdgeInsets(top: 0, left: 120, bottom: 0, right: 0)
        return view
    }()
    let professionalButton = {
        let button = UIButton()
        button.setTitle("프로페셔널 계정으로 전환", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    let personalSettingButton = {
        let button = UIButton()
        button.setTitle("개인정보 설정", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .leading
        return button
    }()
    
    
    
    override func setUpView() {
        viewList.forEach({
            addSubview($0)
        })
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
        }
        profileSettingButton.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.top.equalTo(profileSettingButton.snp.bottom).offset(10)
            make.height.equalTo(300)
            make.bottom.equalTo(professionalButton.snp.top)
        }
        professionalButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(tableView.snp.bottom).offset(10)
            make.height.equalTo(40)
        }
        personalSettingButton.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(professionalButton.snp.bottom)
            make.height.equalTo(40)
            make.bottom.greaterThanOrEqualTo(self.safeAreaLayoutGuide).offset(-200)
        }
        
        
    }
    
}
