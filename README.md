# HUScrollCycle
一张图片实现的轮播图，支持网络图片

# Usage

```swift
 let images = ["a.jpg", "b.jpg","c.jpg","d.jpg",].flatMap {
            return UIImage(named: $0)
 }
        
 let cycleView = HUScrollCycleView(frame: CGRectMake(0, 64, self.view.frame.size.width, 200))
 cycleView.delegate = self
 cycleView.images = images
 cycleView.currentPageIndicatorTintColor = UIColor.redColor()
 self.view.addSubview(cycleView)    
```
加载网络图片：

```swift
cycleView.placeholderImage = UIImage(named:"a.jpg")
cycleView.imageURLStringGroup = ["http://1.7feel.cc/yungou/statics/uploads/banner/20160715/85964915563838.jpg",
                                 "http://1.7feel.cc/yungou/statics/uploads/banner/20160715/20274054563730.jpg",
                                 "http://1.7feel.cc/yungou/statics/uploads/banner/20160715/40912708563719.jpg",
                                 "http://1.7feel.cc/yungou/statics/uploads/touimg/20160718/img193.jpg"];
```

在代理中，你可以得到当前点击图片的下标：

```swift
func scrollCycleView(view: HUScrollCycleView, didSelectedItemAtIndex index: Int) {
        print("tap at \(index)")
}
```
其他一些属性：

属性 | 说明
----|----
`timeInterval`|轮播时间间隔
`pageIndicatorTintColor`|pageControl颜色
`currentPageIndicatorTintColor`|pageControl当前位置颜色
`autoScrollEnable`|是否自动轮播
`pageControlHidden`|是否隐藏pageControl

# Install
下载zip包，解压后将`HUScrollCycleView`文件夹拖入工程中，点击你的工程，在相应的`target`的`Build Settings`中找到`Swift Compiler`，鼠标双击`Objective-C Bridging Header`，将`HUScrollCycle-Bridging-Header.h`拖入到弹出框中，这样`Xcode`就能找到OC的头文件了。
![](http://i2.piimg.com/558621/208b98513be3f12e.png)
# Other
* `HUScrollCycle`中的网络图片下载并没有使用其他第三方库，所以你可以放心使用而不会对你项目产生影响。你只要按照上面的方法正确的导入`HUScrollCycle-Bridging-Header.h`就可以正常使用了。
* `HUScrollCycle`是使用`Swift`版本，如果你需要`OC`版本可以联系我：）


