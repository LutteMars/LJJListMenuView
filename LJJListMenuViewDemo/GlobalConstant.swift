//
//  GlobalConstant.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import Foundation
import UIKit


/**
 创建关于动画效果的枚举类
 
 - zOOM_NONE: 没有动画效果
 - zOOM_IN:   淡出消失
 - zOOM_OUT:  淡入出现
 */
enum ANIMATIONSCALEZOOM: Int {
    case zoom_NONE   = 0
    case zoom_IN
    case zoom_OUT
}

/**
 创建一个关于弹出视图位置的枚举类
 
 - left:   弹出视图位置在父视图的左边
 - center: 弹出视图位置在父视图的中央
 - right:  弹出视图位置在父视图的右边
 - custom: 自定义弹出视图的位置
 */
enum PopViewPositon: Int {
    case left        = 0
    case center
    case right
    case custom
}

/**
 创建一个关于绘图方法类型的枚举类
 
 - systemWithArrowType:         带有箭头的系统绘图方法
 - systemWithOutArrowType:      没有箭头的系统绘图方法
 - bezierPathWithArrowType:     带有箭头的贝塞尔曲线绘图方法
 - bezierPathWihthOutArrowType: 没有箭头的贝塞尔曲线绘图方法
 */
enum DrawUigraphicsType: Int {
//    case systemWithArrowType    = 0 /* 废弃 */
//    case systemWithOutArrowType     /* 废弃 */
    case bezierPathWithArrowType
    case bezierPathWihthOutArrowType
}


/// 获取当前窗口对象
let currentWindow: UIWindow = UIApplication.shared.windows.last!

/// 数字常量：0
let ZERO:CGFloat = 0

/// 动画的持续时间
let ANIMATION_CONTINUE_TIME: TimeInterval = 0.5

/// 弹出下拉列表视图的宽和高
let PopViewWidth: CGFloat = 80
let PopViewHeight: CGFloat = PopViewWidth / 0.618 / 0.618

/// 使用绘制图形的方法类型
let DrawGraphicsMethodType: DrawUigraphicsType = DrawUigraphicsType.bezierPathWithArrowType

/// 需要绘制的三角形指示箭头的底部边长和高
let TriangleBottom: CGFloat = PopViewWidth * 0.12
let TriangleHeight: CGFloat = TriangleBottom * 0.618

/// 下拉列表内部tableView的背景颜色
let BGColorOfTableView: UIColor = UIColor.init(red: 78 / 255, green: 78 / 255, blue: 78 / 255, alpha: 1)

/// 下拉列表内部tableView距离各边的内边距
let PaddingTop: CGFloat = TriangleHeight + 3
let PaddingBottom: CGFloat = 3
let PaddingLeft: CGFloat = 3
let PaddingRight: CGFloat = 3

/// 下拉列表内部tableView的行高
let RowHeightOfTableView: CGFloat = 40

/// 下拉列表边框线颜色和内部填充色
let StrokeColor: CGColor = UIColor.red.cgColor
let FillColor: CGColor = UIColor.clear.cgColor



