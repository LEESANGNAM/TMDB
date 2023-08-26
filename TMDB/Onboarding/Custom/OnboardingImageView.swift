//
//  OnboardingImageView.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import UIKit

class OnboardingImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        backgroundColor = .yellow
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
        clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = 20
    }
}
