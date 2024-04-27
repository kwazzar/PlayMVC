//
//  InfoCell.swift
//  PlayMVC
//
//  Created by Quasar on 27.04.2024.
//

import UIKit

class InfoCell: UITableViewCell {

    @IBOutlet weak var titleInfoCellLabel: UILabel!
    @IBOutlet weak var detailInfoCellLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        titleInfoCellLabel.numberOfLines = 0
                detailInfoCellLabel.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)


    }

}
