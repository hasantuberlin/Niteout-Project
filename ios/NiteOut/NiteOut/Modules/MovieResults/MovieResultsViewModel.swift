//
//  MovieResultsViewModel.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright (c) 2020 Hamza Khan. All rights reserved.
//

import UIKit
import CoreLocation
class MovieResultsViewModel
{
    var date : String!
    var userLong : Double!
    var userLat : Double!
    let repo = RestaurantRepo()
    let cuisinePreference : [String : Int]!
    var arrShowTimes : [ShowTimeShowtime]!
    var arrCinemas : [ShowTimeCinema]!
    var strAddress = ""
    init(_ arrShowTime : [ShowTimeShowtime], _ arrCinemas : [ShowTimeCinema], date: String, userLong: Double , userLat : Double, cuisinePreference: [String : Int]){
        self.arrShowTimes = arrShowTime
        self.arrCinemas = arrCinemas
        self.date = date
        self.userLat = userLat
        self.userLong = userLong
        self.cuisinePreference = cuisinePreference
        convertLatLongToAddress { (address) in
            self.strAddress = address
        }
    }
    
    func getShowTimeCount()->Int{
        return self.arrShowTimes.count
    }
    func cellViewModelForRow(row: Int)-> MovieResultsCellViewModel{
        let result = self.arrShowTimes[row]
        let cinemaId = result.cinemaId ?? ""
        var cinemaName = ""
        var cinemaAddress = ""
        var cinemaLat = 0.0
        var cinemaLong = 0.0
        arrCinemas.forEach { (cinema) in
            if cinema.id == cinemaId{
                cinemaName = cinema.name ?? ""
                cinemaAddress = cinema.address ?? ""
                cinemaLat = cinema.lat ?? 0.0
                cinemaLong = cinema.lon ?? 0.0
            }
        }
        let movieName = result.cinemaMovieTitle ?? ""
        let is3d = result.is3d ?? false
        let movieId = result.movieId ?? ""
        let movieTime = result.startAt ?? ""
        let movieLanguage = result.language ?? ""
        
        return MovieResultsCellViewModel(movieName: movieName, cinemaLat: cinemaLat, cinemaLong: cinemaLong, cinemaName: cinemaName, movieLangugae: movieLanguage, movieTime: movieTime, is3d: is3d, cinemaAddress: cinemaAddress, cinemaId: cinemaId, movieId: movieId)
    }
    func getCinemaData(row: Int)->[String:Any]{
        let result = cellViewModelForRow(row: row)
        return [
            "lat": result.cinemaLat,
            "lon": result.cinemaLong,
            "address": result.cinemaAddress
            ] as [String : Any]
    }
    func convertLatLongToAddress(completionHandler: @escaping( _ address : String)->Void){
        var addressString : String = ""

        var location = CLLocation(latitude: userLat, longitude: userLong) //changed!!!
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                return
            }
            if placemarks!.count > 0 {
                let pm = placemarks![0] as! CLPlacemark
                if pm.subLocality != nil {
                    addressString = addressString + pm.subLocality! + ", "
                }
                if pm.thoroughfare != nil {
                    addressString = addressString + pm.thoroughfare! + ", "
                }
                if pm.locality != nil {
                    addressString = addressString + pm.locality! + ", "
                }
                if pm.country != nil {
                    addressString = addressString + pm.country! + ", "
                }
                if pm.postalCode != nil {
                    addressString = addressString + pm.postalCode! + " "
                }
                completionHandler(addressString)
            }
            else {
                completionHandler(addressString)
            }
        })
    }
    func getUserLocationData()->[String:Any]{
        return [
            "lat": userLat ?? 0.0,
            "lon": userLong ?? 0.0,
            "address": strAddress
            ] as [String : Any]
        
    }
    
    func getRestaurantsResults(row: Int,completionHandler:@escaping (_ success : Bool , _ serverMsg : String ,_ restaurantData : RestaurantDetailRootClass?)->Void){
        let cinemaDict = self.getCinemaData(row: row)
        let userLocation = self.getUserLocationData()
        
        repo.getRestaurantResults(date: date, cinemaData: cinemaDict, userData: userLocation, cuisineData: cuisinePreference) { (success, serverMsg, data) in
            completionHandler(success, serverMsg, data)
            
        }
    }
    
}

