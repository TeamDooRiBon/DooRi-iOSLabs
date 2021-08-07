//
//  ScheduleTableViewCell.swift
//  AlamofireSample
//
//  Created by taehy.k on 2021/07/22.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    static let cellId = "ScheduleTableViewCell"

    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var memoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, memo: String) {
        titleLabel.text = title
        memoLabel.text = memo
    }
}
