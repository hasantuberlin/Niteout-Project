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
		address = try values.decodeIfPresent(String.self, forKey: .address)// ?? String()
		id = try values.decodeIfPresent(String.self, forKey: .id) //?? String()
		lat = try values.decodeIfPresent(Double.self, forKey: .lat)// ?? Float()
		lon = try values.decodeIfPresent(Double.self, forKey: .lon)// ?? Float()
		name = try values.decodeIfPresent(String.self, forKey: .name) //?? String()
		openNow = try values.decodeIfPresent(Bool.self, forKey: .openNow) //?? Bool()
		priceLevel = try values.decodeIfPresent(Int.self, forKey: .priceLevel)// ?? Int()
		rating = try values.decodeIfPresent(Double.self, forKey: .rating) //?? Float()
	}


}
