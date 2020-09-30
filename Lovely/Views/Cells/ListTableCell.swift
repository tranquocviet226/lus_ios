//
//  ListTableCell.swift
//  Lovely
//
//  Created by MacOS on 9/1/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class ListTableCell: UITableViewCell {
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var nameView1: UILabel!
    @IBOutlet weak var statusView1: UIView!
    @IBOutlet weak var ageView1: UILabel!
    @IBOutlet weak var cityView1: UILabel!
    
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var nameView2: UILabel!
    @IBOutlet weak var statusView2: UIView!
    @IBOutlet weak var ageView2: UILabel!
    @IBOutlet weak var cityView2: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    func setupUI() {
        statusView1.addCorner(radius: statusView1.bounds.width / 2)
        statusView2.addCorner(radius: statusView2.bounds.width / 2)
    }
}
