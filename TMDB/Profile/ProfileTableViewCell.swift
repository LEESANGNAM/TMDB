//
//  ProfileTableViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/30.
//

import UIKit


class ProfileTableViewCell: BaseTableViewCell {
    let nameLabel = {
       let label = UILabel()
        label.text = "test"
        return label
    }()
    
    let contentLabel = {
        let label = UILabel()
        label.text = "testconten"
        label.textColor = .systemGray4
        return label
    }()
    
    override func setUpUI() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(contentLabel)
    }
    
    override func setConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.width.equalTo(80)
            make.height.equalTo(30)
            make.leading.equalTo(self).inset(20)
           
        }
        contentLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview().inset(10)
            make.trailing.equalTo(self)
            make.height.equalTo(30)
            make.leading.equalTo(nameLabel.snp.trailing).offset(20)
        }
    }
    
}
