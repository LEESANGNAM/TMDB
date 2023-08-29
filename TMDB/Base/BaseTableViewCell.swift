//
//  BaseTableViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/29.
//

import UIKit

class BaseTableViewCell: UITableViewCell{
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpUI() { }
    func setConstraints(){ }
}
