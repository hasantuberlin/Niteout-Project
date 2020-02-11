//
//	ShowTimeShowtime.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ShowTimeShowtime : Codable {
    
    let cinemaId : String?
    let cinemaMovieTitle : String?
    let is3d : Bool?
    let isImax : Bool?
    let language : String?
    let movieId : String?
    let startAt : String?
    let subtitleLanguage : String?
    
    
    enum CodingKeys: String, CodingKey {
        case cinemaId = "cinema_id"
        case cinemaMovieTitle = "cinema_movie_title"
        case is3d = "is_3d"
        case isImax = "is_imax"
        case language = "language"
        case movieId = "movie_id"
        case startAt = "start_at"
        case subtitleLanguage = "subtitle_language"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
            cinemaId = try values.decodeIfPresent(String.self, forKey: .cinemaId)
        }catch{
            cinemaId = ""
        }
        do{
            cinemaMovieTitle = try values.decodeIfPresent(String.self, forKey: .cinemaMovieTitle)
        }catch{
            cinemaMovieTitle = ""
        }
        do{
            is3d = try values.decodeIfPresent(Bool.self, forKey: .is3d)
        }catch{
            is3d = false
        }
        do{
            isImax = try values.decodeIfPresent(Bool.self, forKey: .isImax) //?? Bool()
        }catch{
            isImax = false
        }
        do{
            language = try values.decodeIfPresent(String.self, forKey: .language) //?? String()
        }catch{
            language = ""
        }
        do{
            movieId = try values.decodeIfPresent(String.self, forKey: .movieId) //?? String()
        }catch{
            movieId = ""
        }
        do{
            startAt = try values.decodeIfPresent(String.self, forKey: .startAt) //?? String()
        }catch{
            startAt = ""
        }
        do{
            subtitleLanguage = try values.decodeIfPresent(String.self, forKey: .subtitleLanguage) //?? String()
        }catch{
            subtitleLanguage = ""
        }
        
    }
    
    
}
