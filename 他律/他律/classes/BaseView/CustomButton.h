//
//  CustomButton.h
//  Foodest
//
//  Created by yunPengZhengYao on 2017/6/14.
//  Copyright © 2017年 yunPengZhengYao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomButton : UIButton

@property (nonatomic, strong) UIView *leftView;

@property (nonatomic, strong) UIImageView *customView;

@property (nonatomic, strong) UIImageView *customTopView;

@property (nonatomic, strong) UILabel *customTitle;

@property (nonatomic, strong) UILabel *customTitle2;

@property (nonatomic, strong) NSArray *customArr;

@end
