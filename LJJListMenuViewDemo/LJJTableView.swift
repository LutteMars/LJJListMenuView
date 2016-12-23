//
//  LJJTableView.swift
//  LJJListMenuViewDemo
//
//  Created by 刘俊杰 on 16/7/6.
//  Copyright © 2016年 刘俊杰. All rights reserved.
//

import UIKit

/// cell被点击后的结果回调函数
public typealias CellClickedBlock = (_ obj: AnyObject) -> Void

class LJJTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var dataArray: [AnyObject]!
    var cellClickedBlock: CellClickedBlock!
    
    // cellId
    static let cellId: String = "cellId"
    
    /**
     LJJTableView初始化方法
     
     - parameter frame:            LJJTableView对象的frame
     - parameter style:            LJJTabeViwe的类型
     - parameter dataArray:        数据源
     - parameter cellClickedBlock: 点击cell后结果的回调
     
     - returns: 返回一个全新的LJJTableView类的对象
     */
    init(frame: CGRect, style: UITableViewStyle, dataArray: [AnyObject], cellClickedBlock: @escaping CellClickedBlock) {
        super.init(frame: frame, style: UITableViewStyle.plain)
        
        self.dataArray = dataArray
        self.cellClickedBlock = cellClickedBlock
        
        /// 设置tableView的背景颜色
        self.backgroundColor = BGColorOfTableView
        /// 隐藏纵向滚动指示器
        self.showsVerticalScrollIndicator = false
        /// 隐藏tableViewCell之间的默认的分割线
        self.separatorStyle = UITableViewCellSeparatorStyle.none
        
        
        /// 设置tableView的行高
        self.rowHeight = RowHeightOfTableView
        
        self.createTableView(self.dataArray)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     创建tableView方法
     
     - parameter dataArray: 数据源
    【特别说明】：在Swift3中，如果一个方法有返回值，而调用的时候没有接收该方法的返回值，
     Xcode会报出警告，告诉你这可能会存在潜在的问题。
    【解决方法】：在该方法前有`discardableResult`关键字修饰。
     */
    
    @discardableResult
    func createTableView(_ dataArray: [AnyObject]) -> LJJTableView {
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    // 出列cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        #if false
            // 1.系统自有cell类型
            let cell = tableView.dequeueReusableCellWithIdentifier(cellId, forIndexPath: indexPath)
            cell.textLabel?.text = self.dataArray[indexPath.row] as? String
        #else
            // 2.自定义cell类型
            let cell = Bundle.main.loadNibNamed("LJJTableViewCell", owner: nil, options: nil)?[0] as! LJJTableViewCell
            cell.listItemLabel.text = self.dataArray[(indexPath as NSIndexPath).row] as? String
            
        #endif
        
        return cell
    }
    
    //MARK: -- Cell点击事件 --
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.cellClickedBlock(self.dataArray[(indexPath as NSIndexPath).row])
    }
    
}
