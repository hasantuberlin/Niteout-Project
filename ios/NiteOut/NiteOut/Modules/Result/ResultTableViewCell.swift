//
//  ResultTableViewCell.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRestaurantPriceLevel    : UILabel!
    @IBOutlet weak var lblRestaurantAddress      : UILabel!
    @IBOutlet weak var lblRestaurantRatiing     : UILabel!
    @IBOutlet weak var lblRestaurantName        : UILabel!
   @IBOutlet weak var lblRestaurantOpenNow        : UILabel!


    
    var viewModel : ResultCellViewModel!{
        didSet{
            
            lblRestaurantOpenNow .text = viewModel.getRestaurantOpenNow()
            lblRestaurantAddress    .text = "\(viewModel.getRestaurantAddress())"
            lblRestaurantRatiing  .text = "\(viewModel.getRestaurantRating())"
            lblRestaurantName     .text = viewModel.getRestaurantName()
            lblRestaurantPriceLevel     .text = viewModel.getRestaurantPriceLevel()

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
