//
//  MovieResultTableViewCell.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class MovieResultTableViewCell: UITableViewCell {
    @IBOutlet weak var lblmovieName             : UILabel!
    @IBOutlet weak var lblmovieLangugae           : UILabel!
    @IBOutlet weak var lblmovieTime            : UILabel!
    @IBOutlet weak var lblis3d         : UILabel!
    @IBOutlet weak var lblcinemaName             : UILabel!
    @IBOutlet weak var lblcinemaAddress           : UILabel!
    
    
    var viewModel : MovieResultsCellViewModel!{
        didSet{
            lblmovieName.text = viewModel.getMovieName()
            lblmovieLangugae.text = viewModel.getLanguage()
            lblmovieTime.text = viewModel.getMovieTime()
            lblis3d.text = viewModel.get3d()
            lblcinemaName.text = viewModel.getCinemaName()
            lblmovieLangugae.text = viewModel.getLanguage()
            lblcinemaAddress.text = viewModel.getAddress()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

struct MovieResultsCellViewModel{
    var movieName : String
    var cinemaLat : Double
    var cinemaLong : Double
    var cinemaName : String
    var movieLangugae : String
    var movieTime : String
    var is3d : Bool
    var cinemaAddress : String
    var cinemaId : String
    var movieId : String
    
    func getCinemaName()-> String{
        return "Cinema Name: " + cinemaName
    }
    func getMovieName()-> String{
        return "Movie Name: " + movieName
    }
    func getMovieId()-> String{
        return movieId
    }
    func getAddress()-> String{
        return "Address: " + cinemaAddress
    }
    func getMovieTime()-> String{
        return "Movie Time: " + movieTime
    }
    func get3d()-> String{
        return "3d: " + is3d.description
    }
    func getLanguage()-> String{
        return "Movie Language: " + movieLangugae
    }
    
    
    
    
    
}
