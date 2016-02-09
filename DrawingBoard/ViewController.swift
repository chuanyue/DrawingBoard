//
//  ViewController.swift
//  DrawingBoard
//
//  Created by huxianming on 16/2/7.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var canvasView: CanvasView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    //选择画笔颜色
    @IBAction func brushColor(sender: UIButton) {
        canvasView.pathColor = sender.backgroundColor
    }
    
    //选择画笔线宽
    @IBAction func lineWidth(sender: UISlider) {
        canvasView.lineWidth = CGFloat(sender.value)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

