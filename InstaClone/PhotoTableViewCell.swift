//
//  PhotoTableViewCell.swift
//  InstaClone
//
//  Created by Jorge Cruz on 3/7/16.
//  Copyright © 2016 Jorge Cruz. All rights reserved.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageOnCell: UIImageView!
    
    @IBOutlet weak var authorOnCell: UILabel!
    @IBOutlet weak var captionOnCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
