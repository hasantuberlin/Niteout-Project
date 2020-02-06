//
//  VotingTableViewCell.swift
//  NiteOut
//
//  Created by Hamza Khan on 17/01/2020.
//  Copyright © 2020 Hamza Khan. All rights reserved.
//

import UIKit

protocol VotingButtonProtocol {
    func didTapOnVoting(row: Int,type : Int)
}
class VotingTableViewCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblCount : UILabel!
    @IBOutlet weak var btnVoting: UIButton!{
        didSet{
            btnVoting.addTarget(self, action: #selector(self.didTapOnVoting), for: .touchUpInside)
        }
    }
    var delegate : VotingButtonProtocol!
    var votingCellViewModel : VotingCellViewModel!{
        didSet{
            lblTitle.text = votingCellViewModel.title
            lblCount.text = "\(votingCellViewModel.votingCount)"
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
    @objc func didTapOnVoting(){
        delegate.didTapOnVoting(row: votingCellViewModel.id,type: votingCellViewModel.type)
    }
    
}

struct VotingCellViewModel {
    var title : String
    var votingCount : Int
    var id : Int
    var type : Int
}
