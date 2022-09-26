//
//  editUsernameTableCell.swift
//  LINK
//
//  Created by APPLE on 19/07/22.
//

import UIKit

class EditUsernameTableCell: UITableViewCell {

    @IBOutlet weak var socialMediaLogo: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
