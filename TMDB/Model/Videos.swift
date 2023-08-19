//
//  Videos.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/20.
//

import Foundation

// MARK: - Videos
struct Videos: Codable {
    let id: Int
    let results: [VideosResult]
}

// MARK: - Result
struct VideosResult: Codable {
    let iso639_1, iso3166_1, name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String
    func changeFormatDateString() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            if let date = dateFormatter.date(from: publishedAt) {
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let changeFormatDate = dateFormatter.string(from: date)
                return "\(changeFormatDate)"
            } else {
                return "\(publishedAt)"
            }
        }
    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}

