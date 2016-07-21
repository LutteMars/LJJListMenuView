//
//  LJJListMenuView.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import UIKit

/// 点击cell后结果的回调
public typealias ResultHandler = (data: AnyObject) -> Void


class LJJListMenuView: UIView {
    
    /// 下拉列表中的tableView
    var contentView: LJJTableView!
    
    /// 单利对象
    static var sharedInstance: LJJListMenuView = {
        return LJJListMenuView(frame: CGRectZero)
    }()
    
    
    /**
     重写视图构造方法
     
     - parameter frame: 下拉列表的frame，后面再调用的时候可以设置为CGRectZero
     
     - returns: 返回下拉列表对象
     */
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 设置创建的新的视图的背景颜色为透明色
        // 默认颜色为黑色
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: ---重写UIView的绘图方法---
    override func drawRect(rect: CGRect) {
        
        // 获得需要绘制的图形的起点
        let point: CGPoint = CGPointMake(PopViewWidth / 2, ZERO)
        // 获得需要绘制的图形的frame
        let size: CGSize = rect.size
        print(size.width)
        print(size.height)
        
        switch DrawGraphicsMethodType {
            
            /**
             *  1.使用系统提供的画图方法画带有箭头的图
             */
        case DrawUigraphicsType.SystemWithArrowType:
            // 获得绘图上下文
            let context: CGContextRef = UIGraphicsGetCurrentContext()!
            
            // 设置抗齿距
            CGContextSetAllowsAntialiasing(context, true)
            
            // 创建绘图的路径
            let path: CGMutablePath = CGPathCreateMutable()
            
            // 设置绘制的图形的透明度，默认值为1：全透明
            CGContextSetAlpha(context, 1)
            
            // 设置边框线的宽度
            CGContextSetLineWidth(context, 2)
            
            // 设置边框线的颜色
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
            
            // 设置图形内部填充的颜色
            CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
            
            // 开始移动的点的位置
            CGPathMoveToPoint(path, nil, point.x, point.y)
            print(point.x)
            print(point.y)
            
            // 开始线性移动，后续准备添加圆角
            CGPathAddLineToPoint(path, nil, point.x + TriangleBottom / 2, point.y + TriangleHeight)
            CGPathAddLineToPoint(path, nil, point.x + size.width, point.y + TriangleHeight)
            CGPathAddLineToPoint(path, nil, point.x + size.width, point.y + size.height + TriangleHeight)
            CGPathAddLineToPoint(path, nil, abs(point.x - size.width / 2), point.y + size.height + TriangleHeight)
            CGPathAddLineToPoint(path, nil, abs(point.x - size.width / 2), point.y + TriangleHeight)
            CGPathAddLineToPoint(path, nil, abs(point.x - TriangleBottom / 2), point.y + TriangleHeight)
            
            // 为上下文添加绘图路径
            CGContextAddPath(context, path)
            
            // 填充路径围成的图形
            CGContextFillPath(context)
            break
            /**
             *  2.使用系统提供的画图方法画没有箭头的图
             */
        case DrawUigraphicsType.SystemWithOutArrowType:
            // 获得绘图上下文
            let context: CGContextRef = UIGraphicsGetCurrentContext()!
            
            // 设置抗齿距
            CGContextSetAllowsAntialiasing(context, true)
            
            // 创建绘图的路径
            let path: CGMutablePath = CGPathCreateMutable()
            
            // 设置绘制的图形的透明度，默认值为1：全透明
            CGContextSetAlpha(context, 1)
            
            // 设置边框线的宽度
            CGContextSetLineWidth(context, 0)
            
            // 设置边框线的颜色
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)
            
            // 设置图形内部填充的颜色
            CGContextSetFillColorWithColor(context, UIColor.grayColor().CGColor)
            
            // 开始移动的点的位置
            CGPathMoveToPoint(path, nil, point.x, point.y)
            print(point.x)
            print(point.y)
            
            // 开始线性移动，后续准备添加圆角
            CGPathAddLineToPoint(path, nil, point.x + size.width, point.y)
            CGPathAddLineToPoint(path, nil, point.x + size.width, point.y + size.height)
            CGPathAddLineToPoint(path, nil, abs(point.x - size.width / 2), point.y + size.height)
            CGPathAddLineToPoint(path, nil, abs(point.x - size.width / 2), point.y)
            CGPathAddLineToPoint(path, nil, point.x, point.y)
            
            // 为上下文添加绘图路径
            CGContextAddPath(context, path)
            
            // 填充路径围成的图形
            CGContextFillPath(context)
            break
            /**
             *  3.使用贝塞尔曲线进行画带有箭头的图
             */
        case DrawUigraphicsType.BezierPathWithArrowType:
            // 创建贝塞尔曲线路径
            let bezierPath = UIBezierPath.init()
            
            // 确定路径的起点
            bezierPath.moveToPoint(point)
            
            // 根据路径添加直线
            bezierPath.addLineToPoint(CGPointMake(point.x + TriangleBottom / 2, point.y + TriangleHeight))
            bezierPath.addLineToPoint(CGPointMake(point.x + PopViewWidth / 2, point.y + TriangleHeight))
            bezierPath.addLineToPoint(CGPointMake(point.x + PopViewWidth / 2, point.y + size.height))
            bezierPath.addLineToPoint(CGPointMake(abs(point.x - size.width / 2), point.y + size.height))
            bezierPath.addLineToPoint(CGPointMake(abs(point.x - size.width / 2), point.y + TriangleHeight))
            bezierPath.addLineToPoint(CGPointMake(abs(point.x - TriangleBottom / 2), point.y + TriangleHeight))
            bezierPath.addLineToPoint(CGPointMake(point.x, point.y))
            
            // 创建图层对象
            let layer: CAShapeLayer = CAShapeLayer.init()
            
            // 确定图层对象的frame(框架)
            layer.bounds = rect
            
            // 确定图层的位置坐标
            layer.position = CGPointMake(rect.size.width / 2, rect.size.height / 2)
            
            // 设置图层边框线的颜色
            layer.strokeColor = StrokeColor
            
            // 设置图层的内部填充颜色
            layer.fillColor = FillColor
            
            // 将贝塞尔曲线的路径作为图层的路径
            layer.path = bezierPath.CGPath
            
            // 将新建的图层添加到当前视图对象图层中
            self.layer.addSublayer(layer)
            break
            /**
             *  4.使用贝塞尔曲线进行画没有箭头的图
             */
        case DrawUigraphicsType.BezierPathWihthOutArrowType:
            break
        }
        
    }
    
    
    //MARK: ---弹出视图添加淡入淡出动画效果---
    func popViewScaleZoom(scaleZoom: ANIMATIONSCALEZOOM) {
        
        switch scaleZoom {
        case .ZOOM_NONE:
            self.transform = CGAffineTransformMakeScale(1.0, 1.0)
            break
        case .ZOOM_OUT:
            self.transform = CGAffineTransformMakeScale(0.0, 0.0)
            /// 具有阻尼效果的动态弹出视图动画
            UIView.animateWithDuration(ANIMATION_CONTINUE_TIME, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIViewAnimationOptions.CurveEaseOut, animations: { 
                self.transform = CGAffineTransformIdentity
                }, completion: { (true) in
                    // do something there when animation completed...
            })
            
            UIView.animateWithDuration(ANIMATION_CONTINUE_TIME / 3, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { 
                //
                }, completion: { (true) in
                    //
            })
            break
        case .ZOOM_IN:
            if self.superview != nil {
                UIView.animateWithDuration(ANIMATION_CONTINUE_TIME, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { 
                    self.transform = CGAffineTransformMakeScale(0.005, 0.005)
                    }, completion: { (true) in
                        self.removeFromSuperview()
                })
            }
            break
            
        } // switch - loop end>>
    }
    
    
    /**
     设置关于弹出视图位置居中的方法
     
     - parameter mainView:      弹出视图的父视图，即弹出视图需要贴近的view
     - parameter dataArray:     LJJTableView对象的数据源
     - parameter resultHandler: 点击相关cell时内容的回调
     
     - returns: 返回一个全新的位置居中的下拉列表视图对象
     */
    func setTheCenterPositionOfPopView(mainView: UIView, dataArray: [AnyObject], resultHandler: ResultHandler) {
        
        LJJListMenuView.sharedInstance = LJJListMenuView.init(frame: CGRectMake(mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2, mainView.frame.origin.y + mainView.frame.size.height, PopViewWidth, PopViewHeight))
        
        // 下拉列表动态弹出
        LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.ZOOM_OUT)
        
        // 将tableView添加到下拉列表中
        LJJListMenuView.sharedInstance.addSubview(LJJListMenuView.sharedInstance.createTableViewInPopView(dataArray, resultHandler: { (data) in
            resultHandler(data: data)
        }))
        
        // 将下拉列表视图添加到当前视图控制器中
        currentWindow.rootViewController?.view.addSubview(LJJListMenuView.sharedInstance)
        // 你同样可以这样使用：
        // self.getCurrentVC().view.addSubview(LJJListMenuView.sharedInstance)
    }
    
    
    /**
     设置关于弹出视图位置的综合方法
     
     - parameter mainViwe:       弹出视图的父视图，即弹出视图需要贴近的view
     - parameter popViewPositon: 弹出视图的位置模式(左、中、右、自定义)
     - parameter offSize:        自定义弹出视图相对于中点位置的偏移量
     - parameter dataArray:      LJJTaleView对象的数据源
     - parameter resultHandler:  点击相关cell时内容的回调
     
     - returns: 返回一个全新的可自定义位置的下拉列表视图对象
     */
    func setTheAllPositionsOfPopView(mainView: UIView, popViewPosition: PopViewPositon, offSize: CGPoint, dataArray: [AnyObject], resultHandler: ResultHandler) {
        
        //        unowned let unSelf: LJJListMenuView = self
        
        switch popViewPosition {
        case .LEFT:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRectMake(mainView.frame.origin.x - PopViewWidth / 2, mainView.frame.origin.y + mainView.frame.size.height, PopViewWidth, PopViewHeight))
            break
        case .CENTER:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRectMake(mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2, mainView.frame.origin.y + mainView.frame.size.height, PopViewWidth, PopViewHeight))
            break
        case .RIGHT:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRectMake(mainView.bounds.size.width / 2, mainView.bounds.height, PopViewWidth, PopViewHeight))
            break
        case .CUSTOM:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRectMake(mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2 + offSize.x, mainView.frame.origin.y + mainView.frame.size.height + offSize.y, PopViewWidth, PopViewHeight))
            break
        }
        
        // 下拉列表动态弹出
        LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.ZOOM_OUT)
        
        // 将tableView添加到下拉列表中
        LJJListMenuView.sharedInstance.addSubview(LJJListMenuView.sharedInstance.createTableViewInPopView(dataArray) { (data) in
            
            // 在这里回调cell点击事件的结果
            resultHandler(data: data)
            
            })
        
        // 将下拉列表视图添加到当前视图控制器中
        self.getCurrentVC().view.addSubview(LJJListMenuView.sharedInstance)
        // 你同样可以这样用：
        // currentWindow.rootViewController?.view.addSubview(LJJListMenuView.sharedInstance)
    }
    
    
    /**
     创建下拉列表中的tableView及点击cell之后的结果回调处理
     
     - parameter dataArray:     tableView的数据源后
     - parameter resultHandler: 点击了cell之后的结果回调
     
     - returns: 返回一个全新的LJJTableView对象
     */
    func createTableViewInPopView(dataArray: [AnyObject], resultHandler: ResultHandler) -> LJJTableView {
        
        self.contentView = LJJTableView.init(frame: CGRectMake(PaddingLeft, PaddingTop, PopViewWidth - PaddingLeft - PaddingRight, PopViewHeight - PaddingTop - PaddingBottom), style: UITableViewStyle.Plain, dataArray: dataArray, cellClickedBlock: { (obj) in
            
            // 在这里执行点击cell之后的结果回调和其他相关操作
            resultHandler(data: obj)
            
            // 点击对应的Cell后下拉列表消失
            LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.ZOOM_IN)
            
        })
        
        return self.contentView
    }
    
    //MARK: ---取得当前显示的视图控制器---
    func getCurrentVC() -> UIViewController {
        var result:UIViewController?
        var window = UIApplication.sharedApplication().keyWindow
        if window?.windowLevel != UIWindowLevelNormal{
            let windows = UIApplication.sharedApplication().windows
            for tmpWin in windows{
                if tmpWin.windowLevel == UIWindowLevelNormal{
                    window = tmpWin
                    break
                }
            }
        }
        
        let fromView = window?.subviews[0]
        if let nextRespnder = fromView?.nextResponder(){
            if nextRespnder.isKindOfClass(UIViewController){
                result = nextRespnder as? UIViewController
            }else{
                result = window?.rootViewController
            }
        }
        return result!
    }
    
}

