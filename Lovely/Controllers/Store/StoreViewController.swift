//
//  StoreViewController.swift
//  Lovely
//
//  Created by MacOS on 8/27/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewCon: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    let images2: [String] = ["https://wakaba.kenminkyosai.or.jp/images/recommend/1580795770.jpg", "https://wakaba.kenminkyosai.or.jp/images/recommend/1580795787.jpg", "https://wakaba.kenminkyosai.or.jp/images/recommend/1580795770.jpg", "https://jssors8.azureedge.net/demos/image-slider/img/px-beach-daylight-fun-1430675-image.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI(){
        setHideNavigation()
        setupBackground()
        scrollView.layoutIfNeeded()
        let width = scrollView.frame.width
        let height = scrollView.frame.height
        
        for index in 0 ..< images2.count {
            let img = UIImageView()
            img.sd_setImage(with: URL(string: images2[index]))
            img.contentMode = .scaleToFill
            img.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
            
            let container = UIStackView(arrangedSubviews: [img])
            container.frame = CGRect(x: width*CGFloat(index), y: 0, width: width, height: height)
            
            scrollView.addSubview(container)
        }
        
        scrollView.contentSize = CGSize(width: width*CGFloat(images2.count), height: height)
        viewCon.addShadowOnly(radius: 10)
    }
}

extension StoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "StoreTableCell", for: indexPath) as? StoreTableCell else {
            return UITableViewCell()
        }
        
        return cell
    }
    
    
}
