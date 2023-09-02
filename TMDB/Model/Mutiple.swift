//
//  Mutiple.swift
//  TMDB
//
//  Created by 이상남 on 2023/09/03.
//
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let multiple = try? JSONDecoder().decode(Multiple.self, from: jsonData)

import Foundation

// MARK: - Multiple
struct Multiple: Codable {
    let page: Int
    let results: [MultipleResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct MultipleResult: Codable {
    let adult: Bool
    let backdropPath: String?
    let id: Int
    let title, originalLanguage, originalTitle, overview: String?
    let posterPath: String?
    let mediaType: MultipleMediaType
    let genreIDS: [Int]?
    let popularity: Double
    let releaseDate: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    let name, originalName: String?
    let gender: Int?
    let knownForDepartment, profilePath: String?
    let knownFor: [KnownFor]?
    let firstAirDate: String?
    let originCountry: [String]?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case name
        case originalName = "original_name"
        case gender
        case knownForDepartment = "known_for_department"
        case profilePath = "profile_path"
        case knownFor = "known_for"
        case firstAirDate = "first_air_date"
        case originCountry = "origin_country"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let adult: Bool
    let backdropPath: String
    let id: Int
    let title, originalLanguage, originalTitle, overview: String
    let posterPath: String
    let mediaType: MediaType
    let genreIDS: [Int]
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case id, title
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case genreIDS = "genre_ids"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

enum MultipleMediaType: String, Codable, CaseIterable {
    case movie = "movie"
    case person = "person"
    case tv = "tv"
}

