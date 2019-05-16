//
//  BannerPageControl.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

class BannerPageControl: UIPageControl {

    
    let pageSpace: CGFloat = 10
    
    let pageHeight: CGFloat = 3
    let pageWidth: CGFloat = 15

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self._layoutSubView()
    }
    
    func _layoutSubView() {
        
        
        let totalWidth = CGFloat((self.subviews.count - 1)) * (pageWidth + pageSpace)
        
        let originX = self.frame.size.width / 2 - totalWidth / 2

        for (index, view) in self.subviews.enumerated() {
        
            let x = originX + CGFloat(index) * (pageWidth + pageSpace)
            
            view.frame = CGRect.init(x: x, y: view.frame.origin.y, width: pageWidth, height: pageHeight)
            
            view.layer.cornerRadius = 1;
            view.layer.masksToBounds = true;
        }
    }
}
