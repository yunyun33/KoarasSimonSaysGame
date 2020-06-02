//
//  RankingCell.swift
//  KoarasSimonSaysGame
//
//  Created by yuikonno on 2020/05/31.
//  Copyright © 2020 yuikonno. All rights reserved.
//

import UIKit
protocol RabkingCellDelegate: AnyObject {
    func didTapDelete(at index: Int)
    
}
class RankingCell: UITableViewCell {

    @IBOutlet weak var rankingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String,
                       score: String) {
        
        rankingLabel.text = "\(name), score:\(score)"
        
    }
}
