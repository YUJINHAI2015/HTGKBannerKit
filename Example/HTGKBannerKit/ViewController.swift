//
//  ViewController.swift
//  HTGKBannerKit
//
//  Created by YUJINHAI2015 on 05/16/2019.
//  Copyright (c) 2019 YUJINHAI2015. All rights reserved.
//

import UIKit

import HTGKBannerKit

class ViewController: UIViewController, HTGKBannerDelegate, HTGKBannerDataSource {
    
    func bannerViewCellIdentifier() -> String {
        return "BannerViewCell"
    }
    
    func bannerViewCellClassForBannerView() -> AnyClass {
        return BannerViewCell.self
    }
    
    func bannerViewCell(_ cell: UICollectionViewCell, for index: NSInteger, bannerView: HTGKBannerView) {
        let customCell = cell as! BannerViewCell
        customCell.setImage(imageUrl: ["ad2","Rectangle Copy","Member card_l1_baiyu","Member card_l2_huangyu"][index])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    func initUI() {
        let bannerView = HTGKBannerView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 150))
        bannerView.delegate = self
        bannerView.dataSource = self
        
        bannerView.isOpenLoop = false
        bannerView.timeInterval = 1
        
        bannerView.pageControl.controlSpacing = 8
        self.view.addSubview(bannerView)
        
    }
    
    func bannerView(_ bannerView: HTGKBannerView, didSelectItemAt index: Int) {
        print(index)
    }
    
    func numberOfRows(_ bannerView: HTGKBannerView) -> Int {
        return 4
    }
    
    func bannerView(_ bannerView: HTGKBannerView, cellForRowAt index: Int) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

}

