//
//  HotIdolCollectionCell.swift
//  Lovely
//
//  Created by MacOS on 9/1/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class HotIdolCollectionCell: UICollectionViewCell {
    @IBOutlet weak var idolImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupUI()
    }
    
    func setupUI() {
        idolImage.addCorner(radius: 10)
        statusView.addCorner(radius: statusView.bounds.width / 2)
    }
}
