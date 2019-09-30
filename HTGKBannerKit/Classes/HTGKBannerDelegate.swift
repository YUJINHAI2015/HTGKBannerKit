//
//  HTGKBannerDelegate.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

@objc public protocol HTGKBannerDelegate: NSObjectProtocol {

    /// 点击图片
    @objc optional func bannerView(_ bannerView: HTGKBannerView, didSelectItemAt index: Int)
}

@objc public protocol HTGKBannerDataSource: NSObjectProtocol {
    /// 返回个数
    func numberOfRows(_ bannerView: HTGKBannerView) -> Int
    /// 需要渲染的cell
    func bannerViewCell(_ cell: UICollectionViewCell, for index: NSInteger, bannerView: HTGKBannerView)

    func bannerViewCellIdentifier() -> String
    @objc optional func bannerViewCellClassForBannerView() -> AnyClass
    @objc optional func bannerViewCellNibForBannerView() -> UINib

}
