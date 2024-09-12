//
//  AreaTableViewCell.swift
//  API
//
//  Created by imac-1681 on 2024/9/12.
//

import UIKit

class AreaTableViewCell: UITableViewCell {

    static let identifie = "AreaTableViewCell"
    @IBOutlet var timeLb: UILabel!
    @IBOutlet var minTLb: UILabel!
    @IBOutlet var cloudLb: UILabel!
    @IBOutlet var feelLb: UILabel!
    @IBOutlet var maxTLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
