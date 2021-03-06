## LJJListMenuView
###目录
[TOC]
### 1.项目简介（Introducation）
--
#### 在Android手机应用开发中，系统为我们提供了Spinner控件来实现下拉列表的选择操作。但是在iOS开发中，系统却没有提供已经集成好的类似功能的控件供我们调用，这也是我动手写这个小插件的初衷。下拉列表，顾名思义：通过点击事件或手势事件激活弹出视图，在此之前我们将所有的选项都集中在该弹出视图上以备选择。为了实现这样的功能，在弹出视图上可以添加一个tableView用于滑动，增强用户的交互性。

### 2.项目功能（Features） 
--
#### *__2.1 样式篇__*
- 两种下拉列表弹出视图绘图方式可选；
- 自定义下拉列表的宽度和高度；
- 自定义下拉列表的边框线的宽度和颜色；
- 自定义下拉列表的背景颜色（建议使用透明颜色）；
- 自定义弹出视图动画持续时间以及动画方式；
- 自定义下拉列表内部tableView的样式，已提供接口；

#### *__2.2 功能篇__*
- 默认下拉列表位置贴近指定视图居中位置显示；
- 自定义下拉列表位置贴近指定视图显示（相对于指定视图的底部中点位置）；

#### *_2.3 更新篇_*
- 支持Swift3.0
- 废弃了系统的绘图方法，使用贝塞尔曲线

### 3.要求（Requirement）
--
- **iOS 8.0+ / Mac OS 10.10+**
- **Xcode 7.3**
- **Swift 3.0**

### 4.交流（Communication）
--
  如果您在浏览和使用该插件的过程中发现了bug或者是不合理的地方，请提供给我您的意见和建议，我将依据您的宝贵意见作出相应的修改和更新。请发邮件至我的邮箱:  **__livjunjie@163.com__**

### 5.使用（Usage）
--
- 将该插件集成到你的项目（工程中）

    ![集成](https://github.com/LutteMars/LJJListMenuView/blob/master/Pictures/add.png)

- 如果您需要修改下拉列表的样式，请在 ![全局常量](https://github.com/LutteMars/LJJListMenuView/blob/master/Pictures/globalconstant.png)文件中修改对应的参数

- 使用默认下拉列表位置贴近指定视图居中显示的方法如下：

    ```Swift
    // 在视图控制器中直接调用默认设置下拉列表位置居中的方法
     LJJListMenuView.sharedInstance.setTheCenterPositionOfPopView(self.itemTF2,     
       dataArray:self.dataArray, resultHandler: { (data) in
       // 在这里进行cell点击事件之后的操作，如获取相应的值...
          unSelf.itemTF2.text = data as? String
      })
    ```
  默认下拉列表的位置[*__该位置指贴近的视图的底边中点的位置__*]居中效果如下图所示：
  ![位置居中](https://github.com/LutteMars/LJJListMenuView/blob/master/Pictures/center.png)
  
- 使用自定义下拉列表位置贴近指定视图显示的方法如下：

    ```Swift
    // 在视图控制器中直接调用自定义下拉列表位置的方法
     LJJListMenuView.sharedInstance.setTheAllPositionsOfPopView(self.itemTF1,
       popViewPosition:PopViewPositon.CUSTOM, offSize: CGPointMake(10, 20), dataArray: self.dataArray, 
       resultHandler: { (data) in
       // 在这里进行cell点击事件之后的操作，如获取相应的值...
          unSelf.itemTF1.text = data as? String
      })
    ```
  自定义下拉列表位置相对于 *__self.itemTF1__* 底部中点位置偏移量为 *__(10,20)__* 效果如下图所示：
  ![自定义位置](https://github.com/LutteMars/LJJListMenuView/blob/master/Pictures/custom.png)
  
### 6.说明（Statement）
--
该插件属于开源项目，欢迎大家使用！
