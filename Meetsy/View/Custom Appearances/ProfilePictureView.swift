//
//  profilePictures.swift
//  LINK
//
//  Created by APPLE on 31/05/22.
// Custom view class for all profile pictures to display on your screen

import Foundation
import UIKit

class profilePictureView: UIImageView{
   
    override func layoutSubviews() {
        super.layoutSubviews()
         //Make the image circle
        self.layer.cornerRadius = self.frame.size.width / 2
        
        self.clipsToBounds = true
        //Set border
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
}
