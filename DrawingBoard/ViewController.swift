//
//  ViewController.swift
//  DrawingBoard
//
//  Created by huxianming on 16/2/7.
//  Copyright © 2016年 chuanyue. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIImagePickerControllerDelegate ,UINavigationControllerDelegate{

    @IBOutlet weak var canvasView: CanvasView!
    @IBOutlet weak var slider: UISlider!
    
    var pathColors = [UIColor]()
    var lineWidths = [CGFloat]()
    
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
    
    //清屏
    @IBAction func clearScreen(sender: AnyObject) {
        canvasView.clearScreen()
    }
    
    //撤销
    @IBAction func undo(sender: AnyObject) {
        canvasView.undo()
    }
    
    //MARK:- 擦除绘画
    /**
    只是利用画布的颜色重画，遮盖需涂改的部分
    */
    @IBAction func eraser(sender: AnyObject) {
        //临时保存擦除前的画笔线宽和画笔颜色
        pathColors.append(canvasView.pathColor!)
        lineWidths.append(canvasView.lineWidth!)
        
        if canvasView.pathColor != UIColor.whiteColor(){
            
            canvasView.pathColor = UIColor.whiteColor()
            
        }else{
            //取出保存的线宽和颜色进行绘画
            canvasView.pathColor = pathColors[0]
            canvasView.lineWidth = lineWidths[0]
            //将线宽调整滑块复位到橡皮擦使用前的位置
            slider.value = Float(lineWidths[0])
            //删除临时保存的线宽颜色数据
            pathColors.removeAll()
            lineWidths.removeAll()
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        canvasView.image = image
        
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func pickerPhoto(sender: UIBarButtonItem) {
        if sender.title == "照片"{
            let pickerVc = UIImagePickerController()
            pickerVc.sourceType = .SavedPhotosAlbum
            
            pickerVc.delegate = self
            
            presentViewController(pickerVc, animated: true, completion: nil)
            sender.title = "删除照片"
        }else if sender.title == "删除照片"{
            sender.title = "照片"
            canvasView.image = UIImage(named: "")
        }
        
    }
    
    
    @IBAction func save(sender: AnyObject) {
        //开启上下文
        UIGraphicsBeginImageContextWithOptions(canvasView.bounds.size, false, 0)
        //获取当前上下文
        let ctx = UIGraphicsGetCurrentContext()
        //将图层渲染到上下文
        canvasView.layer.renderInContext(ctx!)
        //获取上下文图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭上下文
        UIGraphicsEndImageContext()
        
        // 保存画板的内容放入相册
        // image:写入的图片
        // completionTarget图片保存监听者
        // 注意：以后写入相册方法中，想要监听图片有没有保存完成，保存完成的方法不能随意乱写
        UIImageWriteToSavedPhotosAlbum(image, self, "image:didFinishSavingWithError:contextInfo:", nil)
        
    }
    
    func image(image:UIImage,didFinishSavingWithError error:NSError?,contextInfo:AnyObject){
        if error != nil{
            print(error)
        }else{
            print("图片保存成功")

        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

