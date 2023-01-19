//
//  LaunchesTableViewCell.swift
//  ApplaunchTest
//
//  Created by Nitesh jha on 18/01/23.
//

import UIKit

class LaunchesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelSummery: UILabel!
    @IBOutlet weak var labelMission: UILabel!
    @IBOutlet weak var labeldateTime: UILabel!
    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var imageLaunches: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
