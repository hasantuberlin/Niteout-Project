//
//    MovieRepoMovy.swift
//    Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class MovieRepoMovy : Codable {

    let movieId : String?
//    let poster : Any?
    let ratings : Double?
    let runtime : Int?
    let title : String?


    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
//        case poster = "poster"
        case ratings = "ratings"
        case runtime = "runtime"
        case title = "title"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do {
        movieId = try values.decodeIfPresent(String.self, forKey: .movieId)
        }catch{
            movieId = ""
        }
//        poster = try values.decodeIfPresent(Any.self, forKey: .poster) ?? Any()
         do {
        ratings = try values.decodeIfPresent(Double.self, forKey: .ratings)
            }catch{
                ratings = 0.0
            }//?? Double()
        
        do{
        runtime = try values.decodeIfPresent(Int.self, forKey: .runtime) ?? 0// ?? Int()
        }catch{
            runtime = 0
        }
        do{
        title = try values.decodeIfPresent(String.self, forKey: .title) ?? ""// ?? String()
        }catch{
            title = ""
        }
    }


}
