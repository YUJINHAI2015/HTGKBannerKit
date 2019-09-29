//
//  ViewController.swift
//  HTGKBannerKit
//
//  Created by YUJINHAI2015 on 05/16/2019.
//  Copyright (c) 2019 YUJINHAI2015. All rights reserved.
//

import UIKit

import HTGKBannerKit

class ViewController: UIViewController, BannerDelegate, BannerDataSource {
    
    func bannerViewCellIdentifier() -> String {
        return "BannerViewCell"
    }
    
    func bannerViewCellClassForBannerView() -> AnyClass {
        return BannerViewCell.self
    }
    
    func bannerViewCell(_ cell: UICollectionViewCell, for index: NSInteger, bannerView: BannerView) {
        let customCell = cell as! BannerViewCell
        customCell.setImage(imageUrl: ["ad2","Rectangle Copy","ad2","Rectangle Copy"][index])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initUI()
    }
    func initUI() {
        let bannerView = BannerView.init(frame: CGRect.init(x: 0, y: 100, width: self.view.frame.size.width, height: 150))
        bannerView.imageNames = ["ad2","Rectangle Copy","ad2","Rectangle Copy"]
        bannerView.delegate = self
        bannerView.dataSource = self
        self.view.addSubview(bannerView)
        
    }
    
    func bannerView(_ bannerView: BannerView, didSelectItemAt index: Int) {
        print(index)
    }
    
    func numberOfRows(_ bannerView: BannerView) -> Int {
        return 4
    }
    
    func bannerView(_ bannerView: BannerView, cellForRowAt index: Int) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    

}

