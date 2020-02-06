//
//	JourneyData1.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class JourneyData1 : Codable {

	let journey : [JourneyDataJourney]?
	let travelTime : Int?


	enum CodingKeys: String, CodingKey {
		case journey = "Journey"
		case travelTime = "TravelTime"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
         do{
		journey = try values.decodeIfPresent([JourneyDataJourney].self, forKey: .journey) //?? [JourneyDataJourney]()
         }catch{
            journey = []
        }
        do{
		travelTime = try values.decodeIfPresent(Int.self, forKey: .travelTime)// ?? Int()}
        }
        catch{
            travelTime = 0
        }
	}


}
