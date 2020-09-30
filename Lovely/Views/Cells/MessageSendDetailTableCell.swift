//
//  MessageSendDetailTableCell.swift
//  Lovely
//
//  Created by MacOS on 9/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class MessageSendDetailTableCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var messageContent: PaddingLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2
        messageContent.padding(8, 8, 16, 16)
        messageContent.layer.cornerRadius = 15
        messageContent.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
