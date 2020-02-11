//
//  NavigationTableViewCell.swift
//  NiteOut
//
//  Created by Hamza Khan on 04/02/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

class NavigationTableViewCell: UITableViewCell {
    @IBOutlet weak var lblDestination            : UILabel!
    @IBOutlet weak var lblDepartureTime           : UILabel!
    @IBOutlet weak var lblArrivalTime            : UILabel!
    @IBOutlet weak var lblMode            : UILabel!
    @IBOutlet weak var lblStep          : UILabel!
    @IBOutlet weak var lblStop         : UILabel!

    
    var viewModel : NavigationCellViewModel!{
        didSet{
            lblDestination     .text       = viewModel.getDestination()
            lblDepartureTime   .text   = viewModel.getDepartureTime()
            lblArrivalTime     .text       = viewModel.getArrivalTime()
            lblMode            .text      = viewModel.getMode()
            lblStep            .text   = viewModel.getStep()
            lblStop            .text   = viewModel.getStop()
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
