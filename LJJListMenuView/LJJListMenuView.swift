//
//  LJJListMenuView.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import UIKit

/// 点击cell后结果的回调
public typealias ResultHandler = (_ data: AnyObject) -> Void


class LJJListMenuView: UIView {
    
    /// 下拉列表中的tableView
    var contentView: LJJTableView!
    
    /// 单利对象
    static var sharedInstance: LJJListMenuView = {
        return LJJListMenuView(frame: CGRect.zero)
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
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: ---重写UIView的绘图方法---
    override func draw(_ rect: CGRect) {
        
        // 获得需要绘制的图形的起点
        let point: CGPoint = CGPoint(x: PopViewWidth / 2, y: ZERO)
        // 获得需要绘制的图形的frame
        let size: CGSize = rect.size
        print(size.width)
        print(size.height)
        
        switch DrawGraphicsMethodType {
            
            /**
             *  1.使用贝塞尔曲线进行画带有箭头的图
             */
            case DrawUigraphicsType.bezierPathWithArrowType:
                // 创建贝塞尔曲线路径
                let bezierPath = UIBezierPath.init()
            
                // 确定路径的起点
                bezierPath.move(to: point)
                bezierPath.lineCapStyle = CGLineCap.round
                bezierPath.lineJoinStyle = CGLineJoin.round
            
                // 根据路径添加直线
                bezierPath.addLine(to: CGPoint(x: point.x + TriangleBottom / 2, y: point.y + TriangleHeight))
                bezierPath.addLine(to: CGPoint(x: point.x + PopViewWidth / 2, y: point.y + TriangleHeight))
                bezierPath.addLine(to: CGPoint(x: point.x + PopViewWidth / 2, y: point.y + size.height))
                bezierPath.addLine(to: CGPoint(x: abs(point.x - size.width / 2), y: point.y + size.height))
                bezierPath.addLine(to: CGPoint(x: abs(point.x - size.width / 2), y: point.y + TriangleHeight))
                bezierPath.addLine(to: CGPoint(x: abs(point.x - TriangleBottom / 2), y: point.y + TriangleHeight))
                bezierPath.addLine(to: CGPoint(x: point.x, y: point.y))
            
                // 创建图层对象
                let layer: CAShapeLayer = CAShapeLayer.init()
            
                // 确定图层对象的frame(框架)
                layer.bounds = rect
            
                // 确定图层的位置坐标
                layer.position = CGPoint(x: rect.size.width / 2, y: rect.size.height / 2)
            
                // 设置图层边框线的颜色
                layer.strokeColor = StrokeColor
            
                // 设置图层的内部填充颜色
                layer.fillColor = FillColor
            
                // 将贝塞尔曲线的路径作为图层的路径
                layer.path = bezierPath.cgPath
            
                // 将新建的图层添加到当前视图对象图层中
                self.layer.addSublayer(layer)
                break
            /**
             *  2.使用贝塞尔曲线进行画没有箭头的图
             */
            case DrawUigraphicsType.bezierPathWihthOutArrowType:
                // 该方法可自行拓展
                break
        }
        
    }
    
    
    //MARK: ---弹出视图添加淡入淡出动画效果---
    func popViewScaleZoom(_ scaleZoom: ANIMATIONSCALEZOOM) {
        
        switch scaleZoom {
        case .zoom_NONE:
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            break
        case .zoom_OUT:
            self.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            /// 具有阻尼效果的动态弹出视图动画
            UIView.animate(withDuration: ANIMATION_CONTINUE_TIME, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 3, options: UIViewAnimationOptions.curveEaseOut, animations: { 
                self.transform = CGAffineTransform.identity
                }, completion: { (true) in
                    // do something there when animation completed...
            })
            
            UIView.animate(withDuration: ANIMATION_CONTINUE_TIME / 3, delay: 0, options: UIViewAnimationOptions.curveLinear, animations: { 
                //
                }, completion: { (true) in
                    //
            })
            break
        case .zoom_IN:
            if self.superview != nil {
                UIView.animate(withDuration: ANIMATION_CONTINUE_TIME, delay: 0, options: UIViewAnimationOptions(), animations: { 
                    self.transform = CGAffineTransform(scaleX: 0.005, y: 0.005)
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
    func setTheCenterPositionOfPopView(_ mainView: UIView, dataArray: [AnyObject], resultHandler: @escaping ResultHandler) {
        
        LJJListMenuView.sharedInstance = LJJListMenuView.init(frame: CGRect(x: mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2, y: mainView.frame.origin.y + mainView.frame.size.height, width: PopViewWidth, height: PopViewHeight))
        
        // 下拉列表动态弹出
        LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.zoom_OUT)
        
        // 将tableView添加到下拉列表中
        LJJListMenuView.sharedInstance.addSubview(LJJListMenuView.sharedInstance.createTableViewInPopView(dataArray, resultHandler: { (data) in
            resultHandler(data)
        }))
        
        // 将下拉列表视图添加到当前视图控制器中
        currentWindow.rootViewController?.view.addSubview(LJJListMenuView.sharedInstance)
        // 你同样可以这样使用：
//         self.getCurrentVC().view.addSubview(LJJListMenuView.sharedInstance)
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
    func setTheAllPositionsOfPopView(_ mainView: UIView, popViewPosition: PopViewPositon, offSize: CGPoint, dataArray: [AnyObject], resultHandler: @escaping ResultHandler) {
        
        //        unowned let unSelf: LJJListMenuView = self
        
        switch popViewPosition {
        case .left:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRect(x: mainView.frame.origin.x - PopViewWidth / 2, y: mainView.frame.origin.y + mainView.frame.size.height, width: PopViewWidth, height: PopViewHeight))
            break
        case .center:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRect(x: mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2, y: mainView.frame.origin.y + mainView.frame.size.height, width: PopViewWidth, height: PopViewHeight))
            break
        case .right:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRect(x: mainView.bounds.size.width / 2, y: mainView.bounds.height, width: PopViewWidth, height: PopViewHeight))
            break
        case .custom:
            LJJListMenuView.sharedInstance = LJJListMenuView(frame: CGRect(x: mainView.frame.origin.x + (mainView.frame.size.width - PopViewWidth) / 2 + offSize.x, y: mainView.frame.origin.y + mainView.frame.size.height + offSize.y, width: PopViewWidth, height: PopViewHeight))
            break
        }
        
        // 下拉列表动态弹出
        LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.zoom_OUT)
        
        // 将tableView添加到下拉列表中
        LJJListMenuView.sharedInstance.addSubview(LJJListMenuView.sharedInstance.createTableViewInPopView(dataArray) { (data) in
            
            // 在这里回调cell点击事件的结果
            resultHandler(data)
            
            })
        
        // 将下拉列表视图添加到当前视图控制器中
        self.getCurrentVC().view.addSubview(LJJListMenuView.sharedInstance)
        // 你同样可以这样用：
//        currentWindow.rootViewController?.view.addSubview(LJJListMenuView.sharedInstance)
    }
    
    
    /**
     创建下拉列表中的tableView及点击cell之后的结果回调处理
     
     - parameter dataArray:     tableView的数据源后
     - parameter resultHandler: 点击了cell之后的结果回调
     
     - returns: 返回一个全新的LJJTableView对象
     */
    func createTableViewInPopView(_ dataArray: [AnyObject], resultHandler: @escaping ResultHandler) -> LJJTableView {
        
        self.contentView = LJJTableView.init(frame: CGRect(x: PaddingLeft, y: PaddingTop, width: PopViewWidth - PaddingLeft - PaddingRight, height: PopViewHeight - PaddingTop - PaddingBottom), style: UITableViewStyle.plain, dataArray: dataArray, cellClickedBlock: { (obj) in
            
            // 在这里执行点击cell之后的结果回调和其他相关操作
            resultHandler(obj)
            
            // 点击对应的Cell后下拉列表消失
            LJJListMenuView.sharedInstance.popViewScaleZoom(ANIMATIONSCALEZOOM.zoom_IN)
            
        })
        
        return self.contentView
    }
    
    //MARK: ---取得当前显示的视图控制器---
    func getCurrentVC() -> UIViewController {
        var result:UIViewController?
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal{
            let windows = UIApplication.shared.windows
            for tmpWin in windows{
                if tmpWin.windowLevel == UIWindowLevelNormal{
                    window = tmpWin
                    break
                }
            }
        }
        
        let fromView = window?.subviews[0]
        if let nextRespnder = fromView?.next{
            if nextRespnder.isKind(of: UIViewController.self){
                result = nextRespnder as? UIViewController
            }else{
                result = window?.rootViewController
            }
        }
        return result!
    }
    
}

