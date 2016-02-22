//
//  IGCell.swift
//  Instagram Viewer
//
//  Created by Alexander Besson on 2016-02-17.
//  Copyright © 2016 Alexander Besson. All rights reserved.
//

import UIKit

class IGCell: UITableViewCell {

    @IBOutlet weak var lblCaption: UILabel!
    @IBOutlet weak var imgResultPic: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
