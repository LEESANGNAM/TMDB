//
//  MovieAPIManager.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/13.
//

import Foundation
import Alamofire
import SwiftyJSON


class MovieAPIManager {
    
    static let shared = MovieAPIManager()
    
    private init(){ }
    
    
    func callRequest(type: EndPoint, completionHandler: @escaping (MoviePersons) -> () ){
        let url = type.requestURL
        let header: HTTPHeaders = [
              "Authorization": APIKey.TMDBReadKey
            ]
        print(url)
        
        AF.request(url,method: .get,headers: header).validate()
            .responseDecodable(of: MoviePersons.self) { response in
                switch response.result {
                case .success(let value):
                    guard let responseData = response.value else { return }
                    completionHandler(responseData)
                case .failure(let error):
                    print(error)
                }
            }
//            .responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                let json = JSON(value)
//                print(json)
//                completionHandler(json)
//            case .failure(let error):
//                print(error)
//            }
//        }
    }
}


extension MovieAPIManager {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageCDN = "https://image.tmdb.org/t/p/original/"
    
    enum EndPoint {
        case trending
        case credits(Int)
        var requestURL: String {
            let baseURL = MovieAPIManager.baseURL
            switch self{
            case .trending:
                return baseURL + "trending/movie/week"
            case .credits(let id): //movie/569094/credits
                return baseURL + "movie/\(id)/credits"
            }
        }
        
    }
}
