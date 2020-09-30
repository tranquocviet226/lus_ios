//
//  StoryTableCell.swift
//  Lovely
//
//  Created by MacOS on 8/31/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

protocol CollectionInsideTableDelegate:class {
    func cellTaped(data: Story?)
}

class StoryTableCell: UITableViewCell {
    @IBOutlet weak var storyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: CollectionInsideTableDelegate?
    
    var newStory: [Story?] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        
        setupUI()
    }
    
    func setupUI() {
        storyView.addCornerAndShadow(radius: 10)
    }
    
    func getStory(story: [Story]) {
        newStory = story
        collectionView.reloadData()
    }
    
}

extension StoryTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newStory.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionCell", for: indexPath) as? StoryCollectionCell else {
            return UICollectionViewCell()
        }
        cell.imageStory.sd_setImage(with: URL(string: newStory[indexPath.row]?.image_path ?? ""))
        cell.nameLabel.text = newStory[indexPath.row]?.user_name
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 80 , height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.cellTaped(data: newStory[indexPath.row])
    }
}
