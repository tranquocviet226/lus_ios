//
//  RecommendTableCell.swift
//  Lovely
//
//  Created by MacOS on 8/30/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class RecommendTableCell: UITableViewCell, UIScrollViewDelegate {
    
    @IBOutlet weak var recommendView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let TIMER: TimeInterval = 3
    
    var recommend: [String?]? {
        didSet {
            guard let recommend = recommend else { return }
            for index in 0..<recommend.count {
                let _ = Utils.Common.getImageScroll2(for: scrollView, at: index, image: recommend[index] ?? "")
            }
            scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(recommend.count), height: scrollView.frame.height)
            pageControl.numberOfPages = recommend.count
            
            recommendView.addCorner(radius: 10)
            recommendView.addShadow(offset: CGSize(width: 0, height: 3), opacity: 0.3, radius: 3)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let gesture = UITapGestureRecognizer(target: self, action:  #selector(self.onTouchRecommend(_:)))
        recommendView.addGestureRecognizer(gesture)
        
        Timer.scheduledTimer(timeInterval: TIMER, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func onTouchRecommend(_ sender: Any) {
        
    }
    
    @objc func autoScroll() {
        var page = pageControl.currentPage
        guard let count = recommend?.count else { return }
        if page == count - 1 {
            page = 0
        } else {
            page += 1
        }
        
        scrollView.setContentOffset(CGPoint(x: CGFloat(page) * scrollView.frame.width, y: 0), animated: true)
        pageControl.currentPage = page
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = Int(round(scrollView.contentOffset.x/scrollView.bounds.width))
        pageControl.currentPage = page
    }
}
