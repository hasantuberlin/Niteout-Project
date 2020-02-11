//
//	RestaurantDetailRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class RestaurantDetailRootClass : Codable {

	let restaurants : [RestaurantDetailRestaurant]?


	enum CodingKeys: String, CodingKey {
		case restaurants = "Restaurants"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		restaurants = try values.decodeIfPresent([RestaurantDetailRestaurant].self, forKey: .restaurants) ?? [RestaurantDetailRestaurant]()
	}


}