//
//  MoviePeople.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import Foundation

enum CreditType: String,CaseIterable{
    case cast,crew

}
//
//class MoviePeople {
// 
//    let group: CreditType
//    let name: String
//    let profileString: String
//    let department: String
//
//    var profileURL: URL?{
//        return URL(string: MovieAPIManager.imageCDN + profileString)
//    }
//
//    init(group: CreditType, name: String, profileString: String, department: String) {
//        self.group = group
//        self.name = name
//        self.profileString = profileString
//        self.department = department
//    }
//}
//
//
//class Cast: MoviePeople{
//    let character: String
//    init(group: CreditType, name: String, profileString: String, department: String, character: String){
//        self.character = character
//        super.init(group: group, name: name, profileString: profileString, department: department)
//    }
//}
//
//class Crew: MoviePeople{
//    let job: String
//    init(group: CreditType, name: String, profileString: String, department: String, job: String){
//        self.job = job
//        super.init(group: group, name: name, profileString: profileString, department: department)
//    }
//}
