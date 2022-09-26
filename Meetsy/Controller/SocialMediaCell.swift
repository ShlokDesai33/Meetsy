//
//  socialMediaToShareCollectionViewCell.swift
//  LINK
//
//  Created by Yajurva on 20/06/22.
// File to make custom cells/buttons that display social medias that a person s sharing

import UIKit

class SocialMediaCell: UICollectionViewCell {

    //All connection outlets that we configure when we make an instance of the cell
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var socialMediaLogo: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var socialMediaName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
