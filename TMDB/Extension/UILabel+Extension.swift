//
//  UILabel+Extension.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import UIKit

extension UILabel{
    
    func titleLabelStyle(){
        self.textColor = .black
        self.font = .boldSystemFont(ofSize: 17)
    }
    
    func whiteTextWithBlueBackground(){
        self.textColor = .white
        self.backgroundColor = .systemIndigo
        self.font = .systemFont(ofSize: 13)
    }
    func blackTextWithWhiteBackground(){
        self.textColor = .black
        self.backgroundColor = .white
        self.font = .systemFont(ofSize: 13)
    }
    
}
