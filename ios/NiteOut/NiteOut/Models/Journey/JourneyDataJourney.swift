//
//	JourneyDataJourney.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

class JourneyDataJourney : Codable {
    
//    let arrivalPlatform : String?
    let arrivalTime : String?
//    let departurePlatform : String?
    let departureTime : String?
    let destination : String?
    let direction : String?
//    let distance : Int?
//    let lineName : String?
    let mode : String?
    let step : Int?
    let stop : String?
    //	let arrivalPlatform : AnyObject?
    //	let departurePlatform : AnyObject?
    
    
    enum CodingKeys: String, CodingKey {
//        case arrivalPlatform = "ArrivalPlatform"
        case arrivalTime = "ArrivalTime"
//        case departurePlatform = "DeparturePlatform"
        case departureTime = "DepartureTime"
        case destination = "Destination"
        case direction = "Direction"
//        case distance = "Distance"
//        case lineName = "LineName"
        case mode = "Mode"
        case step = "Step"
        case stop = "Stop"
        //		case arrivalPlatform = "ArrivalPlatform"
        //		case departurePlatform = "DeparturePlatform"
    }
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        do{
//            arrivalPlatform = try values.decodeIfPresent(String.self, forKey: .arrivalPlatform)
//        }//?? String()
//        catch{
//            arrivalPlatform = ""
//        }
        do{
            arrivalTime = try values.decodeIfPresent(String.self, forKey: .arrivalTime)// ?? String()
        }//?? String()
        catch{
            arrivalTime = ""
        }
        
    //        do{
    //            departurePlatform = try values.decodeIfPresent(String.self, forKey: .departurePlatform)// ?? String()
    //        }//?? String()
    //        catch{
    //            departurePlatform = ""
    //        }
        
        do{
            departureTime = try values.decodeIfPresent(String.self, forKey: .departureTime)// ?? String()
        }//?? String()
        catch{
            departureTime = ""
        }
        
        do{
            direction = try values.decodeIfPresent(String.self, forKey: .direction)// ?? String()
        }//?? String()
        catch{
            direction = ""
        }
        
        do{
            destination = try values.decodeIfPresent(String.self, forKey: .destination) //?? String()
        }//?? String()
        catch{
            destination = ""
        }
    //        do{
    //            distance = try values.decodeIfPresent(Int.self, forKey: .distance) //?? Int()
    //        }//?? String()
    //        catch{
    //            distance = 0
    //        }
        
//        do{
//            lineName = try values.decodeIfPresent(String.self, forKey: .lineName)// ?? String()
//        }//?? String()
//        catch{
//            lineName = ""
//        }
        do{
            mode = try values.decodeIfPresent(String.self, forKey: .mode)// ?? String()
        }//?? String()
        catch{
            mode = ""
        }
        
        do{
            step = try values.decodeIfPresent(Int.self, forKey: .step)// ?? Int()
        }//?? String()
        catch{
            step = 0
        }
        do{
            stop = try values.decodeIfPresent(String.self, forKey: .stop)// ?? String()
        }//?? String()
        catch{
            stop = ""
        }
        
        
        
        //		arrivalPlatform = try values.decodeIfPresent(AnyObject.self, forKey: .arrivalPlatform) ?? AnyObject()
        //		departurePlatform = try values.decodeIfPresent(AnyObject.self, forKey: .departurePlatform) ?? AnyObject()
    }
    
    
}
