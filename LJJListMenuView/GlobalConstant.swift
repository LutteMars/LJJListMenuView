//
//  GlobalConstant.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import Foundation
import UIKit

/// 获取当前窗口对象
let window: UIWindow = UIApplication.sharedApplication().windows.last!

/// 数字常量：0
let ZERO:CGFloat = 0

/// 是否是系统绘图方法
let IsSystemDrawGraphicsMethod: Bool = true
/// 是否是自定义绘图方法
let IsCustomDrawGraphicsMethod: Bool = false

/// 动画的持续时间
let ANIMATION_CONTINUE_TIME: NSTimeInterval = 0.5

/// 弹出下拉列表视图的宽和高
let PopViewWidth: CGFloat = 80
let PopViewHeight: CGFloat = PopViewWidth / 0.618 / 0.618


/// 需要绘制的三角形指示箭头的底部边长和高
let TriangleBottom: CGFloat = PopViewWidth * 0.12
let TriangleHeight: CGFloat = TriangleBottom * 0.618

/// 下拉列表内部tableView距离各边的内边距
let PaddingTop: CGFloat = TriangleHeight + 3
let PaddingBottom: CGFloat = 3
let PaddingLeft: CGFloat = 3
let PaddingRight: CGFloat = 3

/// 下拉列表边框线颜色和内部填充色
let StrokeColor: CGColor = UIColor.redColor().CGColor
let FillColor: CGColor = UIColor.clearColor().CGColor



