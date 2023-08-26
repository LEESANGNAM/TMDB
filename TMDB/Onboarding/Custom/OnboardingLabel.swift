//
//  OnboardingLabel.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import UIKit

class OnboardingLabel: UILabel{
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUI(){
        font = .boldSystemFont(ofSize: 24)
        numberOfLines = 0
        textColor = .black
        textAlignment = .center
    }
    
    
    
}
