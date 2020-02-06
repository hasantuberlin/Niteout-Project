//
//	JourneyDataToCinema.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class JourneyDataToCinema : Codable {

	let one : JourneyData1?

	enum CodingKeys: String, CodingKey {
		case one    = "1"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		 one   = try values.decodeIfPresent(JourneyData1.self, forKey: .one  )  //?? JourneyData1()
	}
}
