//
//  BaseRepository.swift
//  Halal
//
//  Created by Hamza Khan on 19/11/2019.
//  Copyright © 2019 Hamza. All rights reserved.
//

import Foundation
import Alamofire
import Alamofire_SwiftyJSON
import SwiftyJSON
class BaseRepository{
   static let instance = BaseRepository()
   private init(){}
    func requestService(url : String , method: HTTPMethod, params : Parameters?, header : HTTPHeaders, showSpinner: Bool? = true, completionHandler: @escaping (_ isSuccess : Bool, _ serverMsg : String,_ data: JSON?)->Void){
        if showSpinner ?? true{
      DispatchQueue.main.async{
         ActivityIndicator.shared.showSpinner(nil, title: nil)
      }
        }
        
    
      let requestURL = URL(string:baseURL + url)!
        let serviceRequest = request(requestURL, method: method, parameters: params, encoding: JSONEncoding.prettyPrinted, headers: header )
      serviceRequest.responseSwiftyJSON { (response) in
        if showSpinner ?? true  {
         DispatchQueue.main.async{
            ActivityIndicator.shared.hideSpinner()
         }
        }
         if response.error == nil{
            guard let data = response.value else { return }
//            guard let statusCode = data["statusCode"].int
//                else { return }
//            if statusCode == StatusCode.authExpired.rawValue{
//                completionHandler(false,"",nil)
//                AppRouter.logout()
//            }
            completionHandler(true,"",data )
            
         }
         else{
            let msg = response.error?.localizedDescription
            completionHandler(false,msg ?? "Something went wrong. Please try again.",nil)
         }
         
      }
      
   }
   
  
}
