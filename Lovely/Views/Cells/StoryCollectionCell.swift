//
//  StoryCollectionCell.swift
//  Lovely
//
//  Created by MacOS on 8/31/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class StoryCollectionCell: UICollectionViewCell {
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        imageStory.layer.cornerRadius = imageStory.bounds.width/2
    }
}
