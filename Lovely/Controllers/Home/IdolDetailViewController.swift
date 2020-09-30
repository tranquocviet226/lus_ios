//
//  IdolDetailViewController.swift
//  Lovely
//
//  Created by MacOS on 9/19/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class IdolDetailViewController: UIViewController {
    @IBOutlet weak var idolImageView: UIImageView!
    
    var idolName: String?
    var idolImage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idolImageView.sd_setImage(with: URL(string: idolImage ?? ""), completed: nil)
    }
    @IBAction func sendMessagehandle(_ sender: UIButton) {
        guard let messDetailVC = getVC(MessageDetailViewController.self) else {
            return
        }
        messDetailVC.userIdReceive = idolName
        
        navigationController?.pushViewController(messDetailVC, animated: true)
    }
    
}
