//
//  ViewController.swift
//  HUScrollCycle
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HUScrollCycleViewDelegate {

    let images = ["a.jpg", "b.jpg","c.jpg","d.jpg",].flatMap {
        return UIImage(named: $0)
    }
    
    let imageURLStrs = ["http://p.qq181.com/cms/1212/2012121221524127738.jpg",
                        "http://img.pconline.com.cn/images/upload/upc/tx/photoblog/1503/17/c2/3974346_1426551981202_mthumb.jpg",
                        "http://image.tianjimedia.com/uploadImages/2015/083/30/VVJ04M7P71W2.jpg",
                        "http://img1.3lian.com/2015/a1/114/d/58.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cycleView = HUScrollCycleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 200))
        self.view.addSubview(cycleView)
        cycleView.images = images
        cycleView.currentPageIndicatorTintColor = UIColor.redColor()
        
        let cycleView2 = HUScrollCycleView(frame: CGRectMake(0, 300, self.view.frame.size.width, 200))
        self.view.addSubview(cycleView2)
        cycleView2.delegate = self
        cycleView2.currentPageIndicatorTintColor = UIColor.orangeColor()
        cycleView2.autoScrollEnable = false
        cycleView2.placeholderImage = UIImage(named:"a.jpg")
        cycleView2.imageURLStringGroup = imageURLStrs

    }

    //MARK: HUScrollCycleViewDelegate
    
    func scrollCycleView(view: HUScrollCycleView, didSelectedItemAtIndex index: Int) {
        HUPhotoBrowser .showFromImageView(nil, withURLStrings: imageURLStrs, placeholderImage: UIImage(named: "a.jpg"), atIndex: index, dismiss: nil)
        
    }

}

