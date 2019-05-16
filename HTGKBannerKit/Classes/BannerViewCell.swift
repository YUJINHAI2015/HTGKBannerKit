//
//  BannerViewCell.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit
//import Kingfisher

class BannerViewCell: UICollectionViewCell {
    
    public var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageView = UIImageView.init(frame: self.bounds)
        self.imageView.isUserInteractionEnabled = true
        addSubview(self.imageView)
    }
    func setImage(imageUrl: String){
        if imageUrl.hasPrefix("http") {
            
//            self.imageView.kf.setImage(with: URL(string: imageUrl), placeholder: nil)
        } else {
            self.imageView.image = UIImage(named: imageUrl)
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
