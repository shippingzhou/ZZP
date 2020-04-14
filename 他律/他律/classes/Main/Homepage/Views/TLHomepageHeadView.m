//
//  TLHomepageHeadView.m
//  他律
//
//  Created by sineboy on 2019/12/18.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLHomepageHeadView.h"


@interface TLHomepageHeadView ()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIView *bgView;

@end

@implementation TLHomepageHeadView


-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.titleLbl];
    [self addSubview:self.bannerScrollView];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.bgView.frame = CGRectMake(0,0, J_SCREEN_WIDTH, 179 * layoutBy6());
    self.titleLbl.frame = CGRectMake(0, 33 * layoutBy6(), J_SCREEN_WIDTH, 16 * layoutBy6());
    
    self.bannerScrollView.frame = CGRectMake(0,67.5 * layoutBy6(), J_SCREEN_WIDTH, 103 * layoutBy6());
}

//加载banner
-(void)addBannerToScrollView {
    [self.bannerScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    NSInteger count = self.bannerArr.count;
    self.bannerScrollView.contentSize = CGSizeMake(30 * layoutBy6() + count * 345 * layoutBy6(), 0);
    for (int i = 0; i < count; i++) {
        //MGHomePageBannerModel *bannerModel = self.bannerArr[i];
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.layer.cornerRadius = 10;
        imageV.layer.masksToBounds = YES;
        imageV.frame = CGRectMake(15 * layoutBy6() + 345 * layoutBy6() * i, 0, 324.5 * layoutBy6(), 103 * layoutBy6());
        [imageV sd_setImageWithURL:[NSURL URLWithString:self.bannerArr[i]] placeholderImage:[UIImage imageNamed:@"guanyuwomen.jpg"]];
        imageV.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickBanner:)];
        imageV.userInteractionEnabled = YES;
        [imageV addGestureRecognizer:tap];
        [self.bannerScrollView addSubview:imageV];
        
    }
}


//点击轮播图跳转
-(void)didClickBanner:(UITapGestureRecognizer *)tap {
    
    UIImageView *imageV = (UIImageView *)tap.view;
    if (self.cycleScrollCallBack) {
        self.cycleScrollCallBack(@(imageV.tag));
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIScrollView *)bannerScrollView {
    if (!_bannerScrollView) {
        _bannerScrollView = [[UIScrollView alloc] init];
        _bannerScrollView.backgroundColor = [UIColor whiteColor];
        _bannerScrollView.showsVerticalScrollIndicator = NO;
        _bannerScrollView.showsHorizontalScrollIndicator = NO;
        _bannerScrollView.pagingEnabled = YES;
        
    }
    return _bannerScrollView;
}


-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"他律";
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

@end
