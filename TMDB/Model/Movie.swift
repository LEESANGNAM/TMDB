//
//  Movie.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import Foundation

//"results": [
//        {
//            "adult": false,
//            "backdrop_path": "/4HodYYKEIsGOdinkGi2Ucz6X9i0.jpg",
//            "id": 569094,                                             상세정보 위한 아이디
//            "title": "Spider-Man: Across the Spider-Verse",           제목
//            "original_language": "en",
//            "original_title": "Spider-Man: Across the Spider-Verse",
//            "overview": "After reuniting with Gwen Stacy, Brooklyn’s full-time, friendly neighborhood Spider-Man is catapulted across the Multiverse, where he encounters the Spider Society, a team of Spider-People charged with protecting the Multiverse’s very existence. But when the heroes clash on how to handle a new threat, Miles finds himself pitted against the other Spiders and must set out on his own to save those he loves most.",                                                           설명
//            "poster_path": "/8Vt6mWEReuy4Of61Lnj5Xj704m8.jpg",      포스터이미지 주소
//            "media_type": "movie",
//            "genre_ids": [
//                16,
//                28,
//                12,
//                878
//            ],
//            "popularity": 4485.474,
//            "release_date": "2023-05-31",    개봉일
//            "video": false,
//            "vote_average": 8.479,       평점?
//            "vote_count": 3106
//        },



struct Movie{
    var id: Int
    var title: String
    var overView: String
    var date: String
    var posterURLString: String
    var backIamgeURLString: String
    var rating: Double
    
    var posterImageURL: URL?{
        URL(string: MovieAPIManager.imageCDN + posterURLString )
    }
    var backImageURL: URL?{
        URL(string: MovieAPIManager.imageCDN + backIamgeURLString )
    }
    
    
}
