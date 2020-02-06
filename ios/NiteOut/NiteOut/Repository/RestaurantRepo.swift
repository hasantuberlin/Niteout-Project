//
//  RestaurantRepo.swift
//  NiteOut
//
//  Created by Hamza Khan on 03/02/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//





import Foundation
import Alamofire
import Alamofire_SwiftyJSON
protocol RestaurantRepository{
    func getRestaurantResults(date: String , cinemaData: [String:Any], userData: [String:Any], cuisineData: [String:Int], completionHandler: @escaping (_ success : Bool,_ message : String, _ dashboardData : RestaurantDetailRootClass?) -> Void)

}
class RestaurantRepo: RestaurantRepository{
    
    
    private let url = "restaurants"
    private var isSuccess = false
    private var serverMsg = ""
    
    func getRestaurantResults(date: String, cinemaData: [String:Any], userData: [String:Any], cuisineData: [String:Int], completionHandler: @escaping (Bool, String, RestaurantDetailRootClass?) -> Void) {
        

        let params = [
           "Date": date,
           "CinemaLocation": cinemaData,
            "UserLocation": userData,
            "CuisinePreferences": cuisineData
            ] as [String : Any]
        
        
        let header = ["Content-Type":"application/json"]
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: header) { (success, serverMsg, data) in
            self.isSuccess = success
            if self.isSuccess{
                
                guard let data = data else {return}
                let decoder = JSONDecoder()
                let decodedResults = try? JSONDecoder().decode(RestaurantDetailRootClass.self, from: data.rawData())
                print(decodedResults)
                
                
                
                
                completionHandler(self.isSuccess, self.serverMsg, decodedResults)

                    
            }
            else{
                self.serverMsg = serverMsg
                self.isSuccess = false
                completionHandler(self.isSuccess, self.serverMsg, nil)
            }
            
        }
    }
    
    
}
