//
//  SGInfoAlert.m
//
//  Created by Azure_Sagi on 3/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//  提示工具

#import "SGInfoAlert.h"


@implementation SGInfoAlert

// 画出圆角矩形背景
static void addRoundedRectToPath(CGContextRef context, CGRect rect,
                                 float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if (ovalWidth == 0 || ovalHeight == 0) { 
        CGContextAddRect(context, rect);
        return;
    }
    CGContextSaveGState(context); 
    CGContextTranslateCTM (context, CGRectGetMinX(rect), 
                           CGRectGetMinY(rect));
    CGContextScaleCTM (context, ovalWidth, ovalHeight); 
    fw = CGRectGetWidth (rect) / ovalWidth; 
    fh = CGRectGetHeight (rect) / ovalHeight; 
    CGContextMoveToPoint(context, fw, fh/2); 
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); 
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); 
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); 
    CGContextClosePath(context); 
    CGContextRestoreGState(context); 
}

- (id)initWithFrame:(CGRect)frame bgColor:(CGColorRef)color info:(NSString*)info{
    CGRect viewR = CGRectMake(0, 0, frame.size.width * W_BILI, frame.size.height * H_BILI);
    self = [super initWithFrame:viewR];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        bgcolor_ = color;
        info_ = [[NSString alloc] initWithString:info];
        fontSize_ = frame.size;
    }
    return self;
}

- (void)drawRect:(CGRect)rect{
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 背景0.8透明度
    CGContextSetAlpha(context, .8);
    addRoundedRectToPath(context, rect, 5.0f, 5.0f);
    CGContextSetFillColorWithColor(context, bgcolor_);
    CGContextFillPath(context);
    
    // 文字1.0透明度
    CGContextSetAlpha(context, 1.0);
    float x = (rect.size.width - fontSize_.width) / 2.0;
    float y = (rect.size.height - fontSize_.height) / 2.0;
    CGRect r = CGRectMake(x, y, fontSize_.width, fontSize_.height);

    NSDictionary *attributes= [NSDictionary dictionaryWithObjectsAndKeys:
                               [UIFont systemFontOfSize:kSGInfoAlert_fontSize], NSFontAttributeName,
                               [UIColor whiteColor],NSForegroundColorAttributeName,
                               nil];
    [info_ drawInRect:r withAttributes:attributes];
}


// 从上层视图移除并释放
- (void)remove{
    [self removeFromSuperview];
}


// 渐变消失
- (void)fadeAway{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    self.alpha = .0;
    [UIView commitAnimations];
    [self performSelector:@selector(remove) withObject:nil afterDelay:0.5f];
}

+ (void)showInfo:(NSString *)info 
         bgColor:(CGColorRef)color
          inView:(UIView *)view 
        vertical:(float)height{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:kSGInfoAlert_fontSize],NSFontAttributeName, nil];
    
    CGSize size = [info boundingRectWithSize:kMax_ConstrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

+ (void)showInfo:(NSString*)info inView:(UIView*)view vertical:(float)height
{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:kSGInfoAlert_fontSize],NSFontAttributeName, nil];
    CGSize size = [info boundingRectWithSize:kMax_ConstrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGColorRef color = [[UIColor blackColor] CGColor];
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height*height);
    alert.alpha = 0;
    [view addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

+ (void)showInfo:(NSString*)info inView:(UIView*)view
{
    float height = 90;
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:kSGInfoAlert_fontSize],NSFontAttributeName, nil];
    CGSize size = [info boundingRectWithSize:kMax_ConstrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGColorRef color = [[UIColor blackColor] CGColor];
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    alert.center = CGPointMake(view.center.x, view.frame.size.height - height);
    alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1.0;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

+ (void)showInfo:(NSString *)info
{
    float height = 160;
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:kSGInfoAlert_fontSize],NSFontAttributeName, nil];
    CGSize size = [info boundingRectWithSize:kMax_ConstrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGColorRef color = [[UIColor blackColor] CGColor];
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    CGRect rect = [UIScreen mainScreen].bounds;
    alert.layer.cornerRadius = size.height/2;
    alert.layer.masksToBounds = YES;
    alert.center = CGPointMake(rect.size.width / 2, rect.size.height - height);
    alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}

/**
 *tips显示在window,vertical为显示位置 0-1
 */
+(void)showInfo:(NSString *)info vertical:(float)height
{
    height = height < 0 ? 0 : height > 1 ? 1 : height;
    NSDictionary *attri = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:kSGInfoAlert_fontSize],NSFontAttributeName, nil];
    CGSize size = [info boundingRectWithSize:kMax_ConstrainedSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attri context:nil].size;
    CGRect frame = CGRectMake(0, 0, size.width, size.height);
    CGColorRef color = [[UIColor blackColor] CGColor];
    SGInfoAlert *alert = [[SGInfoAlert alloc] initWithFrame:frame bgColor:color info:info];
    CGRect rect = [UIScreen mainScreen].bounds;
    alert.center = CGPointMake(rect.size.width / 2, rect.size.height*height);
    alert.alpha = 0;
    [[UIApplication sharedApplication].keyWindow addSubview:alert];
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:.3f];
    alert.alpha = 1;
    [UIView commitAnimations];
    [alert performSelector:@selector(fadeAway) withObject:nil afterDelay:1.5];
}
@end
