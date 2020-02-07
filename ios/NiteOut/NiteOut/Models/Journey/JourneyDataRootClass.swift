//
//	JourneyDataRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class JourneyDataRootClass : Codable {

	let toCinema : JourneyDataToCinema?
	let toRestaurant : JourneyDataToCinema?


	enum CodingKeys: String, CodingKey {
		case toCinema = "ToCinema"
		case toRestaurant = "ToRestaurant"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		toCinema = try values.decodeIfPresent(JourneyDataToCinema.self, forKey: .toCinema)  //?? JourneyDataToCinema()
		toRestaurant = try values.decodeIfPresent(JourneyDataToCinema.self, forKey: .toRestaurant)  //?? JourneyDataToCinema()
	}


}
