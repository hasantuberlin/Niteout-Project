//
//  JourneyRepo.swift
//  NiteOut
//
//  Created by Hamza Khan on 03/02/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
//{
//   "Date": "2020-01-31T17:15:00+01:00",
//   "CinemaLocation": {
//           "lat": 52.5059,
//           "lon": 13.3331,
//           "address": "Hardenbergstraße 29A, 10623 Berlin"
//   },
//   "RestaurantLocation": {
//           "lat": 52.5062864,
//           "lon": 13.3178534,
//           "address": "Kantstraße 30, Berlin"
//   },
//   "UserLocation":{
//           "lat": 52.51379,
//           "lon": 13.40342,
//           "address": "Brüderstraße"
//   }
//}

protocol JourneyRepository{
    func getJourneyResults(date: String , cinemaData: [String:Any], userData: [String:Any], restaurantData: [String:Any], completionHandler: @escaping (_ success : Bool,_ message : String, _ dashboardData : JourneyDataRootClass?) -> Void)

}
class JourneyRepo: JourneyRepository{
    
    
    private let url = "journeys"
    private var isSuccess = false
    private var serverMsg = ""
    
    func getJourneyResults(date: String, cinemaData: [String:Any], userData: [String:Any], restaurantData: [String:Any], completionHandler: @escaping (Bool, String, JourneyDataRootClass?) -> Void) {
        

        let params = [
           "Date": date,
           "CinemaLocation": cinemaData,
            "UserLocation": userData,
            "RestaurantLocation": restaurantData
            ] as [String : Any]
        
      
        
        let header = ["Content-Type":"application/json"]
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: header) { (success, serverMsg, data) in
            self.isSuccess = success
            if self.isSuccess{
                
                guard let data = data else {return}
                let decoder = JSONDecoder()
                let decodedResults = try? JSONDecoder().decode(JourneyDataRootClass.self, from: data.rawData())
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
