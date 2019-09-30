//
//  BannerCollectionView.swift
//  HTGKBannerKit
//
//  Created by yujinhai on 2019/5/16.
//  Copyright © 2019 Forever High Tech Ltd. All rights reserved.
//

import UIKit

public class BannerView: UIView {

    
    let timeInterval: TimeInterval = 3
    // 代理
    public weak var delegate: BannerDelegate? {
        didSet {
        }
    }
    public weak var dataSource: BannerDataSource? {
        didSet {
            if let reuseIdentifier = dataSource?.bannerViewCellIdentifier() {
                self.reuseIdentifier = reuseIdentifier
            }
            if let customClass = dataSource?.bannerViewCellClassForBannerView?() {
                collectionView.register(customClass, forCellWithReuseIdentifier: reuseIdentifier)
            } else if let customNib = dataSource?.bannerViewCellNibForBannerView?() {
                collectionView.register(customNib, forCellWithReuseIdentifier: reuseIdentifier)
            }
            
            let count = self.dataSource?.numberOfRows(self) ?? 0
            self.itemCount = count
        }
    }
    
    private var reuseIdentifier: String = ""
    private let pageControlHeight: CGFloat = 20

    private var itemCount: NSInteger = 0 { // 传入数据的个数
        didSet {
            pageControl.numberOfPages = itemCount
        }
    }
    private var reloadCount: NSInteger { // collection刷新的个数
        get {
            return self.itemCount * 20
        }
    }
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
        collectionView.scrollsToTop = false;

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
        page.controlSpacing = 4
        page.controlSize = CGSize(width: 5, height: 5)
        page.currentControlSize = CGSize(width: 30, height: 5)
        page.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.4)
        page.currentPageIndicatorTintColor = UIColor.white

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
    override public func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        if newWindow != nil {
            timer.fireDate = Date(timeIntervalSinceNow: timeInterval)
        } else {
            timer.fireDate = Date.distantFuture
        }
    }
    deinit {
        print("ICycleView deinit success")
    }

}

extension BannerView: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.reloadCount
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        if let _ = self.dataSource?.responds(to: #selector(self.dataSource?.bannerViewCell(_:for:bannerView:))) {

            self.dataSource?.bannerViewCell(cell, for: (indexPath.row % self.itemCount), bannerView: self)
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let _ = self.delegate?.responds(to: #selector(self.delegate?.bannerView(_:didSelectItemAt:))) {
            delegate?.bannerView?(self, didSelectItemAt: indexPath.row)
        }
    }
}
// MARK:- 下标相关
extension BannerView {
    // 当前滑动到第几个index
    func currentIndex() -> Int {

        let index = Int((self.collectionView.contentOffset.x + self.collectionFlowLayout.itemSize.width * 0.5) / self.collectionFlowLayout.itemSize.width)
        
        return max(0, index)
    }
    // 当前page的位置
    func currentPage(scrollAtIndex: Int, totalCount: Int) -> Int {
        return scrollAtIndex % totalCount
    }
    
    // 定时器方法，更新Cell位置
    @objc private func updateCollectionViewAutoScrolling() {
        
        let index = self.currentIndex()
        
        if let indexPath = collectionView.indexPathsForVisibleItems.last {
            // 下一个item
            let nextPath = IndexPath(item: index + 1, section: indexPath.section)
            // 是否滑到最后一个
            if nextPath.item < self.reloadCount {
                collectionView.scrollToItem(at: nextPath, at: .centeredHorizontally, animated: true)
            }else {
                collectionView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: false)
            }
        }
    }
}
// MARK: - 定时器相关
extension BannerView {
    
    // 开始拖拽时,停止定时器
    public func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        timer.fireDate = Date.distantFuture
    }
    // 结束拖拽时,恢复定时器
    public func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        timer.fireDate = Date(timeIntervalSinceNow: timeInterval)
    }
    // 更新pagecontroller index
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = self.currentIndex()
        let currentPage = self.currentPage(scrollAtIndex: index, totalCount: self.itemCount)
        
        pageControl.currentPage = currentPage
    }
}
