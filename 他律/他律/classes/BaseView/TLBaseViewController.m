//
//  TLBaseViewController.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseViewController.h"

@interface TLBaseViewController ()

@end

@implementation TLBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.extendedLayoutIncludesOpaqueBars = YES;
    self.modalPresentationCapturesStatusBarAppearance = NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.navigationController.navigationBar.backgroundColor = hexStringToColor(@"333333");
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    
    [self setupSubViewUI];
}

-(void)setupSubViewUI {
    
}

- (void)creatLeftEnble {
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 44, 44);
    leftBtn.contentEdgeInsets =UIEdgeInsetsMake(0, -20,0, 0);
    leftBtn.imageEdgeInsets =UIEdgeInsetsMake(0, -15,0, 0);
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftItem) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:nil forState:UIControlStateNormal];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItems =@[leftItem];
}

- (void)creatRightWithString:(NSString *)str withHex:(NSString *)hex withFontStr:(CGFloat)fontStr {
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(self.view.bounds.size.width - 44, 0, 44, 44);
    [rightBtn setTitle:str forState:0];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:fontStr];
    [rightBtn setTitleColor:hexStringToColor(hex) forState:0];
    [rightBtn addTarget:self action:@selector(rightItem) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *RightItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
    
    UIBarButtonItem *fixplace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [fixplace setWidth:-10];
    self.navigationItem.rightBarButtonItems = @[fixplace,RightItem];
}

- (void)rightItem {
    
    
}

//左navItem点击
- (void)leftItem {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
