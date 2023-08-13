//
//  Movie.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import Foundation

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
