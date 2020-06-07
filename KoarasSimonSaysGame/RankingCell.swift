//
//  RankingCell.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/05/31.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
    

class RankingCell: UITableViewCell {

    @IBOutlet weak var rankingNumberLabel: UILabel!   
    @IBOutlet weak var rankingNameLabel: UILabel!
    @IBOutlet weak var rankingScoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
