//
//  ResultViewModel.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import Foundation
enum ResultTypes{
    case movie
    case restaurant
    
    func getType()-> Int{
        switch self {
        case .movie:
            return 0
        case .restaurant:
            return 1
        }
    }
}
class ResultViewModel{
    private var arrRestaurants : [RestaurantDetailRestaurant]!
    let cinemaData : [String:Any]
    let userLocation:[String: Any]
    let repo = JourneyRepo()
    let date : String!
    init(_ data : [RestaurantDetailRestaurant], cinemaData : [String: Any], userLocation : [String : Any], date : String) {
        self.arrRestaurants = data
        self.cinemaData = cinemaData
        self.userLocation = userLocation
        self.date = date
//        self.arrResults = [
//                ResultModel(strRestaurantName: "Burger Zimmer", strRestaurantRating: 5, strRestaurantScore: 5, strCuisineType: "Fast Food", restaurantId: 0, strMovieName: "Avengers", strMovieRating: 5, strMovieScore: 5, strMovieType: "Action", movieId: 0),
//                ResultModel(strRestaurantName: "Burger Zimmer", strRestaurantRating: 5, strRestaurantScore: 5, strCuisineType: "Fast Food", restaurantId: 0, strMovieName: "Avengers", strMovieRating: 5, strMovieScore: 5, strMovieType: "Action", movieId: 0),
//                ResultModel(strRestaurantName: "Burger Zimmer", strRestaurantRating: 5, strRestaurantScore: 5, strCuisineType: "Fast Food", restaurantId: 0, strMovieName: "Avengers", strMovieRating: 5, strMovieScore: 5, strMovieType: "Action", movieId: 0)
//        ]
    }
    func getRestaurants()->[RestaurantDetailRestaurant]{
        return arrRestaurants
    }
  
    func cellViewModelForRow(row: Int)-> ResultCellViewModel{
        let result = arrRestaurants[row]
        let address = result.address ?? ""
        let id  = result.id ?? "0"
        let lat  = result.lat ?? 0.0
        let lon  = result.lon ?? 0.0
        let name = result.name ?? ""
        let openNow = result.openNow ?? false
        let priceLevel = result.priceLevel ?? 0
        
        let rating = result.rating ?? 0.0
        
        
        return ResultCellViewModel(restaurantName: name, restaurantRating: rating, restaurantId: id, restaurantLat: lat, restaurantLong: lon, restaurantPriceLevel: priceLevel, restaurantOpenNow: openNow, restaurantAddress: address)
    }
    func getRestaurantDetail(row: Int)->[String:Any]{
        let result = cellViewModelForRow(row: row)
        return [
            "lat": result.restaurantLat,
            "lon": result.restaurantLong,
            "address": result.restaurantAddress
        ]
    }
    func getJourney(row: Int,completionHandler:@escaping (_ success : Bool , _ serverMsg : String ,_ restaurantData : JourneyDataRootClass?)->Void){
        repo.getJourneyResults(date: date, cinemaData: cinemaData, userData: userLocation, restaurantData: self.getRestaurantDetail(row: row)) { (success, serverMsg, data) in
            completionHandler(success, serverMsg,data)
        }

       }
}

struct ResultCellViewModel{
    var restaurantName : String
    var restaurantRating : Double
    var restaurantId : String
    var restaurantLat : Double
    var restaurantLong : Double
    var restaurantPriceLevel : Int
    var restaurantOpenNow : Bool
    var restaurantAddress : String

  
    
    func getRestaurantName()-> String{
        return "Name: " + restaurantName
    }
    func getRestaurantRating()-> String{
        return "Rating: " + "\(restaurantRating)"
    }
    func getRestaurantAddress()-> String{
        return "Score:" + "\(restaurantAddress)"
    }
    func getRestaurantId()-> String{
        return restaurantId
    }
    func getRestaurantOpenNow()-> String{
        return "is open: \(restaurantOpenNow.description)"
    }
    
   func getRestaurantPriceLevel()-> String{
       return "Price Level: \(restaurantPriceLevel)"
   }
    func getRestaurantLat()->Double{
        return restaurantLat
    }
    func getRestaurantLong()->Double{
           return restaurantLong
       }
    
}
struct ResultModel {
    var strRestaurantName : String
    var strRestaurantRating: Int
    var strRestaurantScore : Int
    var strCuisineType : String
    var restaurantId : Int
    
    var strMovieName : String
    var strMovieRating: Int
    var strMovieScore : Int
    var strMovieType : String
    var movieId : Int
    
}
