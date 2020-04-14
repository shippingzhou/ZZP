//
//  TLVerifyCodeBtn.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLVerifyCodeBtn.h"

@interface TLVerifyCodeBtn ()
/*
 * 定时器
 */
@property(strong,nonatomic) NSTimer *timer;
/*
 * 定时多少秒
 */
@property(assign,nonatomic) NSInteger count;

@end

@implementation TLVerifyCodeBtn

#pragma mark - 初始化控件
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        // 配置
        [self setup];
    }
    return self;
}

#pragma mark - 配置
- (void)setup
{
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.backgroundColor = hexStringToColor(@"24d64e");
    [self setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
//    self.layer.cornerRadius = 3.0f;
//    self.layer.masksToBounds = YES;
}
#pragma mark - 添加定时器
- (void)timeFailBeginFrom:(NSInteger)timeCount
{
    self.count = timeCount;
    self.enabled = NO;
    // 加1个定时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeDown) userInfo: nil repeats:YES];
}

#pragma mark - 定时器事件
- (void)timeDown
{
    if (self.count != 1){
        self.count -=1;
        self.enabled = NO;
        self.backgroundColor = hexStringToColor(@"999999");
        [self setTitle:[NSString stringWithFormat:@"剩余%ld秒", self.count] forState:UIControlStateNormal];
    } else {
        self.enabled = YES;
        self.backgroundColor = hexStringToColor(@"24d64e");
        [self setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self.timer invalidate];
    }
}

@end
