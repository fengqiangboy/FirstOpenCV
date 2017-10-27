//
//  MyUtil.h
//  FirstOpenCV
//
//  Created by 奉强 on 2017/10/27.
//  Copyright © 2017年 fengqiangboy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MyUtil : NSObject

/**
 测试函数
 */
+ (void)testCpp;

/**
 实现马赛克功能函数
 
 @param image 要处理的图片
 @param level 马赛克等级，越大越模糊
 @return 处理好的图片
 */
+ (UIImage*)opencvImage:(UIImage*)image level:(int)level;

@end
