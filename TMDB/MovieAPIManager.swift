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
    }
    //영화저보 호출
    func callRequest(type: EndPoint,completionHandler: @escaping ([MovieResult]) -> () ){
        let url = type.requestURL
        let header: HTTPHeaders = [
              "Authorization": APIKey.TMDBReadKey
            ]
        print(url)
        
        AF.request(url,method: .get,headers: header).validate()
            .responseDecodable(of: Movie.self) { response in
                switch response.result {
                case .success(let value):
                    guard let responseMovieData = response.value?.results else { return }
                    completionHandler(responseMovieData)
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
        var requestURL: String {
            let baseURL = MovieAPIManager.baseURL
            switch self{
            case .trending(let page):
                return baseURL + "trending/movie/week?page=\(page)"
            case .credits(let id): //movie/569094/credits
                return baseURL + "movie/\(id)/credits"
            }
        }
        
    }
    
}
