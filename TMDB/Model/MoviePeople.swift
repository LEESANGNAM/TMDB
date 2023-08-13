//
//  MoviePeople.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import Foundation


//
//"cast": [
//    {
//      "adult": false,
//      "gender": 2,
//      "id": 587506,
//      "known_for_department": "Acting",     //
//      "name": "Shameik Moore",
//      "original_name": "Shameik Moore",
//      "popularity": 43.036,
//      "profile_path": "/uJNaSTsfBOvtFWsPP23zNthknsB.jpg",
//      "cast_id": 705,
//      "character": "Miles Morales / Spider-Man (voice)",
//      "credit_id": "6489a4f8e375c000e251ab48",
//      "order": 0
//    },
//
//
//    "crew": [
//        {
//          "adult": false,
//          "gender": 2,
//          "id": 7624,
//          "known_for_department": "Writing",
//          "name": "Stan Lee",
//          "original_name": "Stan Lee",
//          "popularity": 24.195,
//          "profile_path": "/kKeyWoFtTqOPsbmwylNHmuB3En9.jpg",
//          "credit_id": "611752420f0da5005f4e35ee",
//          "department": "Writing",
//          "job": "Characters"
//        },
// 공통 필요한거 name known_for_department: Acting이 두개 포함 제외 시키고, profile_path, 타입? cast, crew
//cast : character   crew job

enum CreditType: String,CaseIterable{
    case cast,crew
    
}

class MoviePeople {
 
    let group: CreditType
    let name: String
    let profileString: String
    let department: String
    
    var profileURL: URL?{
        return URL(string: MovieAPIManager.imageCDN + profileString)
    }
    
    init(group: CreditType, name: String, profileString: String, department: String) {
        self.group = group
        self.name = name
        self.profileString = profileString
        self.department = department
    }
}


class Cast: MoviePeople{
    let character: String
    init(group: CreditType, name: String, profileString: String, department: String, character: String){
        self.character = character
        super.init(group: group, name: name, profileString: profileString, department: department)
    }
}

class Crew: MoviePeople{
    let job: String
    init(group: CreditType, name: String, profileString: String, department: String, job: String){
        self.job = job
        super.init(group: group, name: name, profileString: profileString, department: department)
    }
}
