//
//  MultipelView.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/02.
//

import UIKit

class MultipleView: BaseView {
    let titleLabel = {
        let label = UILabel()
        label.text = "영상~~"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    let tableView = {
        let view = UITableView()
        return view
    }()
    
    override func setUpView() {
        addSubview(titleLabel)
        addSubview(tableView)
    }
    
    override func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide).inset(10)
        }
    }
    
}
