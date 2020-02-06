//
//  MovieTableViewCell.swift
//  NiteOut
//
//  Created by Hamza Khan on 23/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    @IBOutlet weak var lblMovieName             : UILabel!
      @IBOutlet weak var lblMovieRating           : UILabel!
      @IBOutlet weak var lblMovieScore            : UILabel!
      @IBOutlet weak var lblMovieDistance         : UILabel!
      
      
      var viewModel : MovieCellViewModel!{
          didSet{
              lblMovieName          .text = viewModel.getMovietName()
              lblMovieRating        .text = "\(viewModel.getMovieRating())"
              lblMovieScore         .text = "\(viewModel.getMovieScore())"
            lblMovieDistance      .text = viewModel.getMovieType()
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
