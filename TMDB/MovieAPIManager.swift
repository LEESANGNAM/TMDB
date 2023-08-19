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
    
    //영화크루 호출
    func callRequestCredit(type: EndPoint, completionHandler: @escaping (MoviePersons) -> () ){
        let url = type.requestURL
        let header: HTTPHeaders = [
              "Authorization": APIKey.TMDBReadKey
            ]
        print(url)
        let parameters: Parameters = ["language": "ko"]
        AF.request(url,method: .get,parameters: parameters,headers: header).validate()
            .responseDecodable(of: MoviePersons.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    //영화저보 호출
    func callRequestTrending(type: EndPoint,completionHandler: @escaping ([MovieResult]) -> () ){
        let url = type.requestURL
        let header: HTTPHeaders = [
              "Authorization": APIKey.TMDBReadKey
            ]
        print(url)
        let parameters: Parameters = ["language": "ko"]
        AF.request(url,method: .get,parameters: parameters,headers: header).validate()
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value.results)
                case .failure(let error):
                    print(error)
                }
            }
    }
    // similar 비슷한영화
    func callRequestSimiler(type: EndPoint,completionHandler: @escaping (Similer) -> () ){
        let url = type.requestURL
        let header: HTTPHeaders = [
              "Authorization": APIKey.TMDBReadKey
            ]
        print(url)
        let parameters: Parameters = ["language": "ko"]
        AF.request(url,method: .get,parameters: parameters,headers: header).validate()
            .responseDecodable(of: Similer.self) { response in
                switch response.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    
    
}


extension MovieAPIManager {
    static let baseURL = "https://api.themoviedb.org/3/"
    static let imageCDN = "https://image.tmdb.org/t/p/original/"
    
    static func getImageURL(path: String) -> URL? {
        return URL(string: MovieAPIManager.imageCDN + path)
    }
    
    enum EndPoint {
        case trending(Int)
        case credits(Int)
        case similar(Int)
        var requestURL: String {
            let baseURL = MovieAPIManager.baseURL
            switch self{
            case .trending(let page):
                return baseURL + "trending/movie/week?page=\(page)"
            case .credits(let id): //movie/569094/credits
                return baseURL + "movie/\(id)/credits"
            case .similar(let id):
                return baseURL + "movie/\(id)/similar"
            }
        }
        
    }
    
}
