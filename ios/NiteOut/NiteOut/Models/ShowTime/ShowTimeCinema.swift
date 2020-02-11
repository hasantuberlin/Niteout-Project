//
//	ShowTimeCinema.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class ShowTimeCinema : Codable {

	let address : String?
	let id : String?
	let lat : Double?
	let lon : Double?
	let name : String?


	enum CodingKeys: String, CodingKey {
		case address = "address"
		case id = "id"
		case lat = "lat"
		case lon = "lon"
		case name = "name"
	}
	required init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
        do{
		address = try values.decodeIfPresent(String.self, forKey: .address)
        }catch{
            address = ""
        }
        do{
        name = try values.decodeIfPresent(String.self, forKey: .name) //?? String()
        }catch{
            name = ""
        }
        do{
        lon = try values.decodeIfPresent(Double.self, forKey: .lon) //?? Float()
        }catch{
            lon = 0.0
        }
        do{
        lat = try values.decodeIfPresent(Double.self, forKey: .lat) //?? Float()
        }catch{
            lat = 0.0
        }
        do{
        id = try values.decodeIfPresent(String.self, forKey: .id) //?? String()
        }catch{
            id = ""
        }
        
	}


}
