//
//  ShowTimeRepo.swift
//  NiteOut
//
//  Created by Hamza Khan on 03/02/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
protocol ShowTimeRepository{
    func getShowTimeResults(date: String , movieId : String,userLat : Double,userLong: Double, completionHandler: @escaping (_ success : Bool,_ message : String, _ dashboardData : ShowTimeRootClass?) -> Void)

}
class ShowTimeRepo: ShowTimeRepository{
    
    
    private let url = "showtimes"
    private var isSuccess = false
    private var serverMsg = ""
    
    func getShowTimeResults(date: String, movieId: String, userLat: Double, userLong: Double, completionHandler: @escaping (Bool, String, ShowTimeRootClass?) -> Void) {
        
        let params = [
           "Date": date,
           "MovieId": movieId,
            "UserLat": userLat,
            "UserLon": userLong
            ] as [String : Any]
        
        
        let header = ["Content-Type":"application/json"]
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: header) { (success, serverMsg, data) in
            self.isSuccess = success
            if self.isSuccess{
                
                guard let data = data else {return}
                let decoder = JSONDecoder()
              
                let decodedResults = try? JSONDecoder().decode(ShowTimeRootClass.self, from: data.rawData())
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
