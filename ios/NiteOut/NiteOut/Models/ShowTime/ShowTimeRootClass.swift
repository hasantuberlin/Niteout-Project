//
//	ShowTimeRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ShowTimeRootClass : Codable {

	let cinemas : [ShowTimeCinema]?
	let showtimes : [ShowTimeShowtime]?


	enum CodingKeys: String, CodingKey {
		case cinemas = "Cinemas"
		case showtimes = "Showtimes"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		cinemas = try values.decodeIfPresent([ShowTimeCinema].self, forKey: .cinemas) ?? [ShowTimeCinema]()
		showtimes = try values.decodeIfPresent([ShowTimeShowtime].self, forKey: .showtimes) ?? [ShowTimeShowtime]()
	}


}