//
//  VotingViewModel.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import Foundation

enum VotingSections : Int{
    case Movie = 0
    case Cuisine
}
enum VotingSectionTitle {
    case movie
    case cuisine
    func getTitle()->String{
        switch self {
        case .movie:
            return "Movie"
        case .cuisine:
            return "Cuisine"
        }
    }
}

class VotingViewModel {
    var arrMovies : [VotingData]!
    var arrCuisines : [VotingData]!
    let repo = MovieRepo()
    var date : String!
    let userLong : Double!
     let userLat : Double!
    init(_ date : String, userLong : Double , userLat: Double) {
        self.date = date
        self.userLong = userLong
        self.userLat = userLat
        self.arrMovies = [
            VotingData(title: "Action", id: 0, votes: 10, type: VotingSections.Movie.rawValue),
            VotingData(title: "Comedy", id: 1, votes: 5, type: VotingSections.Movie.rawValue),
            VotingData(title: "Romantic", id: 2, votes: 7, type: VotingSections.Movie.rawValue),
            VotingData(title: "Fiction", id: 3, votes: 8, type: VotingSections.Movie.rawValue),
            VotingData(title: "Horror", id: 4, votes: 1, type: VotingSections.Movie.rawValue)
        ]
        self.arrCuisines = [

            VotingData(title: "Asian", id: 0, votes: 10, type: VotingSections.Cuisine.rawValue),
            VotingData(title: "German", id: 1, votes: 5, type: VotingSections.Cuisine.rawValue),
            VotingData(title: "Turkish", id: 2, votes: 7, type: VotingSections.Cuisine.rawValue),
            VotingData(title: "Indian", id: 3, votes: 8, type: VotingSections.Cuisine.rawValue),
            VotingData(title: "Mexican", id: 4, votes: 1, type: VotingSections.Cuisine.rawValue)
        ]
    }
    func getMovies()-> [VotingData]{
        return arrMovies
    }
    func getCuisines()-> [VotingData]{
        return arrCuisines
    }
    func getSections()->Int{
        return 2
    }
    func setData(row: Int, section: Int, votes : Int){
        if section == VotingSections.Movie.rawValue{
            arrMovies[row].votes = votes
        }
        else{
            arrCuisines[row].votes = votes
        }
    }
    func getTitleForSection(section : Int)->String{
        if section == VotingSections.Movie.rawValue{
            return VotingSectionTitle.movie.getTitle()
        }
        else{
            return VotingSectionTitle.cuisine.getTitle()
        }
    }
    func getRowsForSection(section : Int)-> Int{
        if section == VotingSections.Movie.rawValue{
            return arrMovies.count
        }
        else{
            return arrCuisines.count
        }
    }
    func cellViewModelForRow(row: Int, section : Int)-> VotingCellViewModel{
        if section == VotingSections.Movie.rawValue{
            let movieGenre = self.arrMovies[row]
            return VotingCellViewModel(title: movieGenre.title, votingCount: movieGenre.votes, id: movieGenre.id, type: movieGenre.type)
        }
        else{
            let cuisine = self.arrCuisines[row]
            return VotingCellViewModel(title: cuisine.title, votingCount: cuisine.votes, id: cuisine.id, type: cuisine.type)
        }
    }
    func getCuisinePreference()->[String : Int]{
        return arrCuisines.reduce([String: Int]()) { (dict, voting) -> [String: Int] in
            var dict = dict
            dict[voting.title] = voting.votes
            return dict
        }
    }
    func postData(completionHandler:@escaping (_ success : Bool , _ serverMsg : String ,_ movies : [MovieRepoMovy]?)->Void){
        var genre : [String:Int] = [String:Int]()

        genre = arrMovies.reduce([String: Int]()) { (dict, voting) -> [String: Int] in
            var dict = dict
            dict[voting.title] = voting.votes
            return dict
        }
        print(genre)
        repo.getMovies(date: date, genreDict: genre, userLat: userLat, userLong: userLong) { (success, serverMsg, data) in
            completionHandler(success, serverMsg,data)
        }
    }
}

struct VotingData {
    var title : String
    var id : Int
    var votes : Int
    var type : Int
}
