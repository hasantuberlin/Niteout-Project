//
//  RepositoryImplementation.swift
//  Niteout
//
//  Created by Hamza Khan on 05/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
protocol MovieRepository{
    func getMovies(date: String , genreDict : [String:Int],userLat : Double,userLong: Double, completionHandler: @escaping (_ success : Bool,_ message : String, _ dashboardData : [MovieRepoMovy]?) -> Void)

}
class MovieRepo: MovieRepository{
    
    
    private let url = "movies"
    private var isSuccess = false
    private var serverMsg = ""
    
    func getMovies(date: String, genreDict: [String : Int], userLat: Double, userLong: Double, completionHandler: @escaping (Bool, String, [MovieRepoMovy]?) -> Void) {
        
        let params = [
           "Date": date,
           "GenrePreferences": genreDict,
            "UserLat": userLat,
            "UserLon": userLong
            ] as [String : Any]
        
        let headers = [
          "Content-Type": "application/json",
          "cache-control": "no-cache",
          "Postman-Token": "ce237a02-a01f-4f66-86d3-216a8f218cd5"
        ]
        let parameters = [
          "Date": "2020-01-31T17:15:00+01:00",
          "GenrePreferences": [
            "Action": 10,
            "Comedy": 2,
            "Romantic": 5,
            "Fiction": 9,
            "Horror": 4
          ],
          "UserLat": userLat,
          "UserLon": userLong
        ] as [String : Any]
        
        
        
        BaseRepository.instance.requestService(url: url, method: .post, params: params, header: headers) { (success, serverMsg, data) in
            self.isSuccess = success
            if self.isSuccess{
                
                guard let data = data else {return}
                let decoder = JSONDecoder()
              
                let decodedResults = try? JSONDecoder().decode(MovieRepoRootClass.self, from: data.rawData())
                print(decodedResults)
                
                
                
                completionHandler(self.isSuccess, self.serverMsg, decodedResults?.movies)

                    
            }
            else{
                self.serverMsg = serverMsg
                self.isSuccess = false
                completionHandler(self.isSuccess, self.serverMsg, nil)
            }
            
        }
    }
    
    
}
