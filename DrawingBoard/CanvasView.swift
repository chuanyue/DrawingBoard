//
//  CanvasView.swift
//  DrawingBoard
//
//  Created by huxianming on 16/2/9.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class CanvasView: UIView {
    
    var path:DrawPath!
    var curP:CGPoint!
    var paths = [DrawPath]()
    var pathColor:UIColor?
    var lineWidth:CGFloat?
    
    //MARK:- 初始化
    // 仅仅是加载xib的时候调用
    override func awakeFromNib() {
        //添加手势
        let pan = UIPanGestureRecognizer.init(target: self, action: "pan:")
        self.addGestureRecognizer(pan)
    }
    
    // 当手指拖动的时候调用
    func pan(pan:UIPanGestureRecognizer){
        // 获取当前手指触摸点
        curP = pan.locationInView(self)
        // 获取开始点
        if pan.state == .Began{
            // 创建贝瑟尔路径
            path = DrawPath.init()
            // 设置路径的起点
            path.moveToPoint(curP)
            // 保存描述好的路径
            paths.append(path)
        }
        
        // 手指一直在拖动
        // 添加线到当前触摸点并设置相关属性
        if path != nil{
            
            path.addLineToPoint(curP)
            
            //设置画笔宽
            if lineWidth != nil{
                path.lineWidth = lineWidth!
            }
            
            //设置画笔颜色
            if pathColor != nil{
                path.pathColor = pathColor!
            }
        }
    
        //重绘
        setNeedsDisplay()
    }
    
    // 绘制图形
    // 只要调用drawRect方法就会把之前的内容全部清空
    override func drawRect(rect: CGRect) {
        
        if !paths.isEmpty {
            for path in paths{
                if path.pathColor != nil{
                    path.pathColor.set()
                }
                path.stroke()
            }
        }
    }
}
