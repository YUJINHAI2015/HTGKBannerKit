//
//  BannerCollectionView.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

let cellIdentifier = "BannerViewCell"

public class BannerView: UIView {

    private let pageControlHeight: CGFloat = 20
    
    public var imageNames: [String]? {
        didSet {
            timer.fireDate = Date(timeIntervalSinceNow: timeInterval)
            pageControl.numberOfPages = imageNames!.count
        }
    }
    
    let timeInterval: TimeInterval = 3
    
    // 代理
    public weak var delegate: BannerDelegate?
    // collectionView
    private lazy var collectionView: UICollectionView! = {
        let collectionView = UICollectionView.init(frame: bounds,
                                    collectionViewLayout: self.collectionFlowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(BannerViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    private lazy var collectionFlowLayout: UICollectionViewFlowLayout! = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = bounds.size
        layout.minimumLineSpacing = 0.0
        layout.minimumInteritemSpacing = 0.0
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()
    
    // 图片滚动指示器
    private lazy var pageControl: BannerPageControl = {
        let page = BannerPageControl(frame: CGRect(x: 0, y: bounds.height - pageControlHeight, width: bounds.width, height: pageControlHeight))
        page.isUserInteractionEnabled = false
        page.pageIndicatorTintColor = .gray
        page.currentPageIndicatorTintColor = .red
        return page
    }()

    // 定时器
    private lazy var timer: Timer = {
        let timer = Timer(timeInterval: timeInterval, target: self, selector: #selector(updateCollectionViewAutoScrolling), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.default)
        return timer
    }()

    public override init(frame: CGRect) {
        super.init(frame: frame)
        // 滚动到中间位置
        self.addSubview(self.collectionView)
        self.addSubview(self.pageControl)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    public override func removeFromSuperview() {
        super.removeFromSuperview()
        self.timer.invalidate()
    }
    
    deinit {
        print("ICycleView deinit success")
    }

}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageNames!.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: BannerViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! BannerViewCell
        cell.setImage(imageUrl: self.imageNames![indexPath.row])
        cell.backgroundColor = .white
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.bannerView?(self, didSelectItemAt: indexPath.row)
    }
}
// MARK: - 定时器相关
extension BannerView {
    
    // 定时器方法，更新Cell位置
    @objc private func updateCollectionViewAutoScrolling() {
        
        if let indexPath = collectionView.indexPathsForVisibleItems.last {
            // 下一个item
            var nextPath = IndexPath(item: indexPath.item + 1, section: indexPath.section)
            
            if nextPath.item < imageNames!.count {
                collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
            }else {
                collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            }
        }
    }
    
    // 开始拖拽时,停止定时器
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.fireDate = Date.distantFuture
    }
    
    // 结束拖拽时,恢复定时器
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = Date(timeIntervalSinceNow: timeInterval)
    }
    // update pageController
    open func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        var page = Int(offsetX / bounds.size.width+0.5)
        page = page % imageNames!.count
        if pageControl.currentPage != page {
            pageControl.currentPage = page
        }
    }

}
