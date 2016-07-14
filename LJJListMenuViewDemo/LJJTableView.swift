//
//  LJJTableView.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import UIKit

/// cell被点击后的结果回调函数
public typealias CellClickedBlock = (obj: AnyObject) -> Void

/// cellId
let cellId: String = "cellId"

class LJJTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: [AnyObject]!
    var cellClickedBlock: CellClickedBlock!
    
    /**
     LJJTableView初始化方法
     
     - parameter frame:            LJJTableView对象的frame
     - parameter style:            LJJTabeViwe的类型
     - parameter dataArray:        数据源
     - parameter cellClickedBlock: 点击cell后结果的回调
     
     - returns: 返回一个全新的LJJTableView类的对象
     */
    init(frame: CGRect, style: UITableViewStyle, dataArray: [AnyObject], cellClickedBlock: CellClickedBlock) {
        super.init(frame: frame, style: UITableViewStyle.Plain)
        
        self.dataArray = dataArray
        self.cellClickedBlock = cellClickedBlock
        
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        
        self.createTableView(self.dataArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     创建tableView方法
     
     - parameter dataArray: 数据源
     */
    func createTableView(dataArray: [AnyObject]) -> LJJTableView {
        self.delegate = self
        self.dataSource = self
        
        #if false
            self.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellId)
        #else
            // 如果是自定义cell，则不需要注册！
        #endif
        
        return self
    }
    
    //MARK: -- TableView协议代理方法 --
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    // 出列cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        #if false
            // 1.系统自有cell类型
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
            cell.textLabel?.text = self.dataArray[indexPath.row] as? String
        #else
            // 2.自定义cell类型
            let cell = NSBundle.mainBundle().loadNibNamed("LJJTableViewCell", owner: nil, options: nil)[0] as! LJJTableViewCell
            cell.listItemLabel.text = self.dataArray[indexPath.row] as? String
            
        #endif
        
        return cell
    }
    
    //MARK: -- Cell点击事件 --
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.cellClickedBlock(obj: self.dataArray[indexPath.row])
        
        
    }
    
}
