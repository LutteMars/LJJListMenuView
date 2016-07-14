//
//  ViewController.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var itemTF1: UITextField!
    @IBOutlet weak var itemTF2: UITextField!
    
    var dataArray: [AnyObject]!
    
    // 控件是否被点击，防止多次点击事件发生
    var isClicked: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 实例化数据源对象
        self.dataArray = ["apple", "orange", "tiger", "mouse", "lion"]
        self.isClicked = true
    }
    
    // 调用自定义下拉列表位置方法
    @IBAction func chooseCustomBtnClicked(sender: UIButton) {
        unowned let unSelf:ViewController = self
        
        if self.isClicked == true {
            LJJListMenuView.sharedInstance.setTheAllPositionsOfPopView(self.itemTF1, popViewPosition: PopViewPositon.CUSTOM, offSize: CGPointMake(10, 20), dataArray: self.dataArray, resultHandler: { (data) in
                unSelf.itemTF1.text = data as? String
                unSelf.isClicked = true
            })
            
            unSelf.isClicked = false
        }
        
    }
    
    // 调用下拉列表位置默认居中方法
    @IBAction func chooseCenterBtnClicked(sender: UIButton) {
        unowned let unSelf:ViewController = self
        
        if self.isClicked == true {
            LJJListMenuView.sharedInstance.setTheCenterPositionOfPopView(self.itemTF2, dataArray: self.dataArray, resultHandler: { (data) in
                unSelf.itemTF2.text = data as? String
                unSelf.isClicked = true
            })
            
            self.isClicked = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

