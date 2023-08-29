//
//  ProfileType.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/30.
//

import Foundation

enum ProfileType: CaseIterable {
    case name
    case userID
    case genderPronoun
    case introduce
    case link
    case gender
    
    var text: String {
        switch self {
        case .name:
            return "이름"
        case .userID:
            return "사용자 이름"
        case .genderPronoun:
            return "성별 대명사"
        case .introduce:
            return "소개"
        case .link:
            return "링크"
        case .gender:
            return "성별"
        }
    }
}
