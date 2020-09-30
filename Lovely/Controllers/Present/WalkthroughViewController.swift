//
//  WalkthroughViewController.swift
//  Lovely
//
//  Created by MacOS on 8/26/20.
//  Copyright © 2020 Tran Viet. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    let images: [UIImage] = [#imageLiteral(resourceName: "walkImg1"), #imageLiteral(resourceName: "walkImg3"), #imageLiteral(resourceName: "walkImg2"), #imageLiteral(resourceName: "walkImg3")]
    let titles: [Localizable.Walkthrough] = [.Slide1, .Slide2, .Slide3, .Slide4]
    let subTitles: [Localizable.Walkthrough] = [.SubTitle1, .SubTitle2, .SubTitle3, .SubTitle4]
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.delegate = self
        
        setupUI()
        setupButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if _UserDefault.get(key: .walkthrought) != nil {
            guard let navigation = getVC(LoginNavigationController.self) else {
                return
            }
            
            self.present(navigation, animated: true)
        }
    }
    
    func setupUI(){
        scrollView.layoutIfNeeded()
        let width = scrollView.frame.width
        let height = scrollView.frame.height
        
        for index in 0 ..< images.count {
            let titleLabel = UILabel()
            titleLabel.numberOfLines = 0
            titleLabel.attributedText = titles[index].localized.setSizeFont(style: .bold, size: 33, tracking: false)
            titleLabel.textAlignment = .center
            
            let subTitleLabel = PaddingLabel()
            subTitleLabel.numberOfLines = 0
            subTitleLabel.attributedText = subTitles[index].localized.setSizeFont(size: 19, tracking: true)
            subTitleLabel.textAlignment = .center
            subTitleLabel.padding(20, 0, 0, 0)
            
            let img = UIImageView(image: images[index])
            img.contentMode = .scaleAspectFit
            img.setContentCompressionResistancePriority(UILayoutPriority(749), for: .vertical)
            
            let container = UIStackView(arrangedSubviews: [img, titleLabel, subTitleLabel])           
            container.frame = CGRect(x: width*CGFloat(index), y: 0, width: width, height: height)
            
            container.axis = .vertical
            container.isLayoutMarginsRelativeArrangement = true
            container.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 0, trailing: 30)
            
            scrollView.addSubview(container)
        }
        
        scrollView.contentSize = CGSize(width: width*CGFloat(images.count), height: height)
        pageControl.numberOfPages = images.count
        pageControl.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        setPageInfo(page: 0)
    }
    
    private func setupBackground(){
        view.setGradientBackground(colorTop: UIColor(hex: "#fbf7f4"), colorBottom: UIColor(hex: "#fce9eb"))
    }
    
    private func setupButton(){
        nextButton.addCorner(radius: nextButton.frame.width/2)
        nextButton.addShadow(color: Colors.red_start.value, offset: CGSize(width: 0, height: 10), opacity: 0.8, radius: 10)
    }
    
    private func setPageInfo(page: Int) {
        pageControl.currentPage = page
    }
    
    private func setPageOffset(page: Int) {
        if page >= 0 && page < images.count {
            scrollView.setContentOffset(CGPoint(x: scrollView.frame.width * CGFloat(page), y: 0), animated: true)
        }
    }
    
    @IBAction func nextHandle(_ sender: UIButton) {
        _UserDefault.set(key: .walkthrought, value: true)
        guard let navigation = getVC(LoginNavigationController.self) else {
            return
        }
        
        self.present(navigation, animated: true)
    }
}

extension WalkthroughViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x/scrollView.frame.width
        setPageInfo(page: Int(round(page)))
    }
}

