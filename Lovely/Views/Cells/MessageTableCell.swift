//
//  MessageTableCell.swift
//  Lovely
//
//  Created by MacOS on 9/10/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class MessageTableCell: UITableViewCell {
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var networkManager: NetworkManager = {
        return NetworkManager()
    }()
    
    var room: RoomInfo? {
        didSet {
            guard let room = room else {
                return
            }
            networkManager.loadMessageDtail(roomId: room.roomId ){ (response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                    }
                    if let response = response {
                        if response.count > 0 {
                            self.contentLabel.text = (response[response.count - 1]).content
                        } else {
                            self.contentLabel.text = ""
                        }
                    }
                }
            }
            networkManager.getUserInfo(id: room.userIdReceive){(response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        print(error)
                    }
                    if let response = response {
                        self.avatarImage.sd_setImage(with: URL(string: response.data?.user?.image ?? "girl"))
                    }
                }
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        avatarImage.layer.cornerRadius = avatarImage.frame.width/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
