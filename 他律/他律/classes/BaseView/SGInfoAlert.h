//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define H_BILI                      1.5             //高比例
#define W_BILI                      1.5             //宽比例
#define kSGInfoAlert_fontSize       18              //字体大小
#define kSGInfoAlert_width          300
#define kMax_ConstrainedSize        CGSizeMake(300, 100)

@interface SGInfoAlert : UIView{
    CGColorRef bgcolor_;
    NSString *info_;
    CGSize fontSize_;
}

/**
 *info为提示信息，frame为提示框大小，view是为消息框的superView（推荐Tabbarcontroller.view)
 *vertical 为垂直方向上出现的位置 从 取值 0 ~ 1。
 */
+ (void)showInfo:(NSString*)info 
         bgColor:(CGColorRef)color
          inView:(UIView*)view 
        vertical:(float)height;

/**
 *缺省背景颜色
 */

+ (void)showInfo:(NSString*)info
          inView:(UIView*)view
        vertical:(float)height;


/**
 *缺省背景颜色,显示位置,默认位置屏幕高度-60 将HUD添加到window上，就算页面替换了也会显示在最上层
 */

+ (void)showInfo:(NSString*)info
          inView:(UIView*)view;

/**
 *讲hud显示在window
 */

+ (void)showInfo:(NSString *)info;

/**
 *tips显示在window,vertical为显示位置 0-1
 */
+(void)showInfo:(NSString *)info vertical:(float)height;
@end
