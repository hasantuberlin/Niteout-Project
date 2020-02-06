//
//  MovieViewModel.swift
//  NiteOut
//
//  Created by Hamza Khan on 23/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import Foundation

class MovieViewModel{
    private var arrMovie : [MovieRepoMovy]!
    let repo = ShowTimeRepo()
    let date : String!
    let userLong : Double!
    let userLat : Double!
    let cuisinePreference : [String : Int]!
    init(_ arrMovies : [MovieRepoMovy], date : String , userLong : Double , userLat: Double , cuisinePreference : [String : Int]) {
        self.arrMovie = arrMovies
        self.date = date
        self.userLong = userLong
        self.userLat = userLat
        self.cuisinePreference = cuisinePreference
        
    }
    func getResults()->[MovieRepoMovy]{
        return arrMovie
    }
    func cellViewModelForRow(row: Int)-> MovieCellViewModel{
        let result = arrMovie[row]
        let title = result.title ?? "N/A"
        let rating = result.ratings ?? 0.0
        let runtime = result.runtime ?? 0
        let movieID = result.movieId ?? "N/A"
        
        
        return MovieCellViewModel(movieName: title, movieRating: rating, movieScore: runtime, movieId: movieID, movieType: "")
    }
    func getShowtimeResults(row : Int,completionHandler:@escaping (_ success : Bool , _ serverMsg : String ,_ showTimeResults : ShowTimeRootClass?)->Void){
        let result = self.cellViewModelForRow(row: row)
        
        repo.getShowTimeResults(date: date, movieId: result.getMovieId(), userLat:  userLat, userLong: userLong) { (success, serverMsg, data) in
            completionHandler(success, serverMsg, data)
        }
    }
}


struct MovieCellViewModel {
    var movieName : String
    var movieRating : Double
    var movieScore : Int
    var movieId : String
    var movieType : String
    func getMovietName()-> String{
        return "Name:" + movieName
    }
    func getMovieRating()-> String{
        return "Rating:" + "\(movieRating)"
    }
    func getMovieScore()-> String{
        return "Votes:" + "\(movieScore)"
    }
    func getMovieId()-> String{
        return movieId
    }
    func getMovieType()-> String{
        return "Genre: " + movieType
    }
    
}
