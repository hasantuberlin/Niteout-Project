//
//    MovieRepoRootClass.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MovieRepoRootClass : Codable {

    let movies : [MovieRepoMovy]?


    enum CodingKeys: String, CodingKey {
        case movies = "Movies"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        movies = try values.decodeIfPresent([MovieRepoMovy].self, forKey: .movies) ?? [MovieRepoMovy]()
    }


}
