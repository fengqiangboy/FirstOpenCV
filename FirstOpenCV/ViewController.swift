//
//  ViewController.swift
//  FirstOpenCV
//
//  Created by 奉强 on 2017/10/27.
//  Copyright © 2017年 fengqiangboy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        MyUtil.testCpp()
    }
    
    
    /// 显示原图按钮
    @IBAction func origImageBtnClick(_ sender: Any) {
        imageView.image = UIImage(named: "pic.jpg")
    }
    
    /// 显示马赛克图片
    @IBAction func mosaicImageBtnClick(_ sender: Any) {
        guard let origImage = imageView.image else {
            return
        }
        
        let mosaicImage = MyUtil.opencvImage(origImage, level: 20)
        imageView.image = mosaicImage
    }
    
}

