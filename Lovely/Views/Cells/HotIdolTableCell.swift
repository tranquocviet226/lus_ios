//
//  HotIdolTableCell.swift
//  Lovely
//
//  Created by MacOS on 9/1/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class HotIdolTableCell: UITableViewCell {
    @IBOutlet weak var hotIdolView: UIView!
    @IBOutlet weak var hotIdolLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        hotIdolView.addCornerAndShadow(radius: 10)
    }    
}

extension HotIdolTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotIdolCollectionCell", for: indexPath) as? HotIdolCollectionCell else {return UICollectionViewCell()}
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 120, height: 230)
    }
    
}
