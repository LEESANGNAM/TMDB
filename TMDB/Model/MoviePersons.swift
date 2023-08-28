//
//  MoviePersons.swift
//  TMDB
//
//  Created by 이상남 on 2023/08/15.
//


import Foundation

// MARK: - MoviePerson
struct MoviePersons: Codable {
    let id: Int
    let cast, crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: Department
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: Department?
    let job: String?
    var characterJobString : String{
        if let characterJob = character ?? job{
            return "\(characterJob) / \(knownForDepartment )"
        }
        return ""
    }
    

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

enum Department: String, Codable {
    case Creator = "Creator"
    case acting = "Acting"
    case art = "Art"
    case camera = "Camera"
    case costumeMakeUp = "Costume & Make-Up"
    case crew = "Crew"
    case directing = "Directing"
    case editing = "Editing"
    case lighting = "Lighting"
    case production = "Production"
    case sound = "Sound"
    case visualEffects = "Visual Effects"
    case writing = "Writing"
}

enum CreditType: String,CaseIterable{
    case cast,crew

}
