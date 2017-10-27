//
//  MyUtil.m
//  FirstOpenCV
//
//  Created by 奉强 on 2017/10/27.
//  Copyright © 2017年 fengqiangboy. All rights reserved.
//

//导入OpenCV框架 最好放在Foundation.h UIKit.h之前
//核心头文件
#import <opencv2/opencv.hpp>
//对iOS支持
#import <opencv2/imgcodecs/ios.h>
//导入矩阵帮助类
#import <opencv2/highgui.hpp>
#import <opencv2/core/types.hpp>

#import "MyUtil.h"
#import <iostream>

using namespace std;
using namespace cv;

@implementation MyUtil

+ (void)testCpp {
    cout << "Hello Swift and Cpp" << endl;
}

+ (UIImage*)opencvImage:(UIImage*)image level:(int)level {
    //实现功能
    //第一步：将iOS图片->OpenCV图片(Mat矩阵)
    Mat mat_image_src;
    UIImageToMat(image, mat_image_src);
    
    //第二步：确定宽高
    int width = mat_image_src.cols;
    int height = mat_image_src.rows;
    
    //在OpenCV里面，必须要先把ARGB的颜色空间转换成RGB的，否则处理会失败
    //ARGB->RGB
    Mat mat_image_dst;
    cvtColor(mat_image_src, mat_image_dst, CV_RGBA2RGB, 3);
    
    //为了不影响原始图片，克隆一张保存
    Mat mat_image_clone = mat_image_dst.clone();
    
    //第三步：马赛克处理
    int xMax = width - level;
    int yMax = height - level;
    
    for (int y = 0; y <= yMax; y += level) {
        for (int x = 0; x <= xMax; x += level) {
            
            
            //让整个矩形区域颜色值保持一致
            //mat_image_clone.at<Vec3b>(i, j)->像素点（颜色值组成->多个）->ARGB->数组
            //mat_image_clone.at<Vec3b>(i, j)[0]->R值
            //mat_image_clone.at<Vec3b>(i, j)[1]->G值
            //mat_image_clone.at<Vec3b>(i, j)[2]->B值
            Scalar scalar = Scalar(
                                   mat_image_clone.at<Vec3b>(y, x)[0],
                                   mat_image_clone.at<Vec3b>(y, x)[1],
                                   mat_image_clone.at<Vec3b>(y, x)[2]);
            
            //取出要处理的矩形区域
            Rect2i mosaicRect = Rect2i(x, y, level, level);
            Mat roi = mat_image_dst(mosaicRect);
            
            //将前面处理的小区域拷贝到要处理的区域
            //CV_8UC3的含义
            //CV_:表示框架命名空间
            //8表示：32位色->ARGB->8位 = 1字节 -> 4个字节
            //U: 无符号类型
            //C分析：char类型
            //3表示：3个通道->RGB
            Mat roiCopy = Mat(mosaicRect.size(), CV_8UC3, scalar);
            roiCopy.copyTo(roi);
        }
    }
    
    //第四步：将OpenCV图片->iOS图片
    return MatToUIImage(mat_image_dst);
}

@end
