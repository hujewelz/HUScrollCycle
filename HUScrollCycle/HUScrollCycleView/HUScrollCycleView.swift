//
//  HUScrollCycleView.swift
//  HUScrollCycle
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

import UIKit

@objc public protocol HUScrollCycleViewDelegate: NSObjectProtocol {
    
    optional func scrollCycleView(view: HUScrollCycleView, didSelectedItemAtIndex index: Int)
}


public class HUScrollCycleView: UIView {

    public var images: [UIImage] = [] {
        willSet {
            imageCounts = newValue.count
            imageView.image = newValue.first
            pageControl.numberOfPages = newValue.count
        }
    }
    
    public var imageURLStringGroup: [String] = [] {
        willSet {
            imageCounts = newValue.count
            
            guard let url = NSURL(string: newValue.first!) else {
                return
            }
            imageView .hu_setImageWithURL(url, placeholderImage: placeholderImage)
            pageControl.numberOfPages = newValue.count
        }
    }
    
    public var timeInterval = 3.0 {
        didSet {
            if autoScrollEnable {
                stopTimer()
                refreshTimer()
            }
        }
    }
    
    public var pageIndicatorTintColor = UIColor.lightGrayColor() {
        willSet {
            pageControl.pageIndicatorTintColor = newValue
        }
    }
    
    public var currentPageIndicatorTintColor = UIColor.whiteColor() {
        willSet {
            pageControl.currentPageIndicatorTintColor = newValue
        }
    }

    public var autoScrollEnable = true {
        willSet {
            if newValue {
                refreshTimer()
            }
            else {
                stopTimer()
            }
        }
    }
    
    public var pageControlHidden = false {
        willSet {
            pageControl.hidden = newValue
        }
    }

    // use only load the web image
    public var placeholderImage: UIImage?
    public weak var delegate: HUScrollCycleViewDelegate?
  
    private var timer: NSTimer?
    private var index = 0
    private var imageCounts = 0
    
    private enum ScrollDirection {
        case Left, Right
    }
    
    //MARK: life cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.whiteColor()
        addSubview(self.imageView)
        addSubview(self.pageControl)
        addConstraints()
        addGesture()
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func willMoveToWindow(newWindow: UIWindow?) {
        super.willMoveToWindow(newWindow)
        self.imageView.layer.removeAllAnimations()
        guard let _ = newWindow else {
            stopTimer()
            return
        }
        refreshTimer()
    }
    
    //MARK: lazy property
    lazy var imageView: UIImageView = {
        let imageV = UIImageView()
        imageV.userInteractionEnabled = true
        imageV.translatesAutoresizingMaskIntoConstraints = false
        return imageV
    }()
    
    lazy var pageControl: UIPageControl = {
        let pageC = UIPageControl()
        pageC.currentPage = 0
        pageC.translatesAutoresizingMaskIntoConstraints = false
        return pageC
    }()
    
    //MARK: gesture
    private func addGesture() {
        let left = UISwipeGestureRecognizer(target: self, action: #selector(self.swipGesterHandelr(_:)))
        left.direction = .Left
        self.imageView.addGestureRecognizer(left)
        
        let right = UISwipeGestureRecognizer(target: self, action: #selector(self.swipGesterHandelr(_:)))
        right.direction = .Right
        self.imageView.addGestureRecognizer(right)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapGesterHandelr(_:)))
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc private func swipGesterHandelr(sender: UISwipeGestureRecognizer) {
        stopTimer()
        
        if sender.state == .Ended {
            switch sender.direction {
            case UISwipeGestureRecognizerDirection.Left:
                scrollWithDirection(.Left)
            case UISwipeGestureRecognizerDirection.Right:
                scrollWithDirection(.Right)
            default:
                break
            }
            
            refreshTimer()
        }
    }
    
    @objc private func tapGesterHandelr(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            delegate?.scrollCycleView?(self, didSelectedItemAtIndex: index)
           
        }
    }

    //MARK: TIMER
    private func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func refreshTimer() {
        if timer == nil && autoScrollEnable {
            timer = NSTimer.scheduledTimerWithTimeInterval(timeInterval, target: self, selector: #selector(self.timeAction), userInfo: nil, repeats: true)
        }
    }
    
    @objc private func timeAction() {
        scrollWithDirection(.Left)
    }
    
    private func scrollWithDirection(direction: ScrollDirection) {
        switch direction {
        case .Left:
            index += 1
            if index > imageCounts - 1 {
                index = 0
            }
        case .Right:
            index -= 1
            if index < 0 {
                index = imageCounts - 1
            }
        }
        
        if images.count > 0 {
            self.imageView.image = images[index]
        }
        else {
            if let url = NSURL(string: imageURLStringGroup[index]) {
                self.imageView.hu_setImageWithURL(url, placeholderImage: placeholderImage)
            }
        }
        
        addScrollAnimationWithDirection(direction)
    }
    
    private func addScrollAnimationWithDirection(direction: ScrollDirection) {
        let animation = CATransition()
        animation.duration = 0.4
        animation.type = kCATransitionPush
        
        switch direction {
        case .Left:
            animation.subtype = kCATransitionFromRight
        case .Right:
            animation.subtype = kCATransitionFromLeft
        }
        
        self.imageView.layer.addAnimation(animation, forKey:"scroll")
        self.pageControl.currentPage = index
    }
    
    private func addConstraints() {
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[imageView]-0-|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: ["imageView": imageView]))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[imageView]-0-|",
            options: .DirectionLeadingToTrailing,
            metrics: nil,
            views: ["imageView": imageView]))
        
        self.addConstraint(NSLayoutConstraint(item: self.pageControl,
            attribute: .Bottom,
            relatedBy: .Equal,
            toItem: self,
            attribute: .Bottom,
            multiplier: 1,
            constant: 10))
        self.addConstraint(NSLayoutConstraint(item: self.pageControl,
            attribute: .CenterX,
            relatedBy: .Equal,
            toItem: self,
            attribute: .CenterX,
            multiplier: 1,
            constant: 0))
    
    }

}
