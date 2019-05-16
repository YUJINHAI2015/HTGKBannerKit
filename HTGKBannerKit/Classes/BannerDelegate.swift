//
//  BannerDelegate.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

@objc public protocol BannerDelegate: NSObjectProtocol {

    /// 点击图片
    @objc optional func bannerView(_ bannerView: BannerView, didSelectItemAt index: Int)
}
