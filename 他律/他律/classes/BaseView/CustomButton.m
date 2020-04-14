//
//  CustomButton.m
//  Foodest
//
//  Created by yunPengZhengYao on 2017/6/14.
//  Copyright © 2017年 yunPengZhengYao. All rights reserved.
//

#import "CustomButton.h"

@implementation CustomButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubViewToButton];
    }
    return self;
}

-(void)addSubViewToButton {
    self.leftView = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view;
    });
    
    self.customView = ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(0, 0, 0, 0);
        [self addSubview:imageV];
        imageV;
    });
    
    self.customTopView = ({
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(0, 0, 0, 0);
        [self addSubview:imageV];
        imageV;
    });
    
    self.customTitle = ({
        UILabel *lbl = [[UILabel alloc] init];
        lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbl];
        lbl;
    });
    self.customTitle2 = ({
        UILabel *lbl = [[UILabel alloc] init];
        lbl.textAlignment = NSTextAlignmentCenter;
        [self addSubview:lbl];
        lbl;
    });
    
    self.customArr = [NSArray array];
}

@end
