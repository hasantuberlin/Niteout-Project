//
//	RestaurantDetailRestaurant.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class RestaurantDetailRestaurant : Codable {

	let address : String?
	let id : String?
	let lat : Double?
	let lon : Double?
	let name : String?
	let openNow : Bool?
	let priceLevel : Int?
	let rating : Double?


	enum CodingKeys: String, CodingKey {
		case address = "address"
		case id = "id"
		case lat = "lat"
		case lon = "lon"
		case name = "name"
		case openNow = "open_now"
		case priceLevel = "price_level"
		case rating = "rating"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
		address = try values.decodeIfPresent(String.self, forKey: .address)// ?? String()
        }catch{
            address = ""
        }
        do{
		id = try values.decodeIfPresent(String.self, forKey: .id) //?? String()
        }catch{
            id = "0"
        }
        do{
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)// ?? Float()
        }catch{
            lat = 0.0
        }
        do{
        lon = try values.decodeIfPresent(Double.self, forKey: .lon)// ?? Float()
        }catch{
            lon = 0.0
        }
        do{
        name = try values.decodeIfPresent(String.self, forKey: .name) //?? String()
        }catch{
            name = ""
        }
        do{
		openNow = try values.decodeIfPresent(Bool.self, forKey: .openNow) //?? Bool()
        }catch{
            openNow = false
        }
        do{
        priceLevel = try values.decodeIfPresent(Int.self, forKey: .priceLevel)// ?? Int()
        }catch{
            priceLevel = 0
        }
        do{
        rating = try values.decodeIfPresent(Double.self, forKey: .rating) //?? Float()
        }catch{
            rating = 0.0
        }
	}


}
