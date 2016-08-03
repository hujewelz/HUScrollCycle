//
//  ViewController.swift
//  HUScrollCycle
//
//  Created by mac on 16/8/2.
//  Copyright © 2016年 hujewelz. All rights reserved.
//

import UIKit

class ViewController: UIViewController, HUScrollCycleViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let images = ["a.jpg", "b.jpg","c.jpg","d.jpg",].flatMap {
//            return UIImage(named: $0)
//        }
        
        let cycleView = HUScrollCycleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 200))
        self.view.addSubview(cycleView)
        cycleView.delegate = self
        //cycleView.images = images
        cycleView.currentPageIndicatorTintColor = UIColor.redColor()
        cycleView.placeholderImage = UIImage(named:"a.jpg")
        cycleView.imageURLStringGroup = ["http://1.7feel.cc/yungou/statics/uploads/banner/20160715/85964915563838.jpg",
                                         "http://1.7feel.cc/yungou/statics/uploads/banner/20160715/20274054563730.jpg",
                                         "http://1.7feel.cc/yungou/statics/uploads/banner/20160715/40912708563719.jpg",
                                         "http://1.7feel.cc/yungou/statics/uploads/touimg/20160718/img193.jpg"];
    }

    //MARK: HUScrollCycleViewDelegate
    
    func cycleView(view: HUScrollCycleView, didSelectedItemAtIndex index: Int) {
        print("tap at \(index)")
    }

    
}

