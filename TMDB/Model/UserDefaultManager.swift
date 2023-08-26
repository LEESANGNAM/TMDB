//
//  UserDefaultManager.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/26.
//

import Foundation

class UserDefaultManager{ // PropertyWrapper는 학습후 추가예정
    
    static let standard = UserDefaultManager()
    
    private init(){}
    
    let userDefaults = UserDefaults.standard
    
    
    enum UserDefaultsKey: String{
        case isSelect
        }
}

extension UserDefaultManager {
    var isSelect: Bool{
        get{
            return userDefaults.bool(forKey: UserDefaultsKey.isSelect.rawValue)
        }
        set{
            userDefaults.set(newValue, forKey: UserDefaultsKey.isSelect.rawValue)
            
        }
    }
    
}
