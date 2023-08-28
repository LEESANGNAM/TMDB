//
//  BaseCollectionViewCell.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/28.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpView(){ }
    
    func setConstraints(){ }
    
    
}
