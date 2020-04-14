//
//  TLHongbaoYidakaiView.m
//  他律
//
//  Created by sineboy on 2019/12/24.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLHongbaoYidakaiView.h"

@interface TLHongbaoYidakaiView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *hongbaoView;

@property (nonatomic, strong) UILabel *openLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation TLHongbaoYidakaiView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.hongbaoView];
    [self addSubview:self.openLbl];
    [self addSubview:self.tipsLbl];
    [self addSubview:self.closeBtn];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
    self.hongbaoView.frame = CGRectMake(36 * layoutBy6(), 163 * layoutBy6(), 302 * layoutBy6(), 397 * layoutBy6());
    self.closeBtn.frame = CGRectMake(J_SCREEN_WIDTH - 45.5 * layoutBy6() - 26 * layoutBy6(), 115.5 * layoutBy6(), 26 * layoutBy6(), 26 * layoutBy6());
    self.openLbl.frame = CGRectMake(J_SCREEN_WIDTH/2 - 60/2 * layoutBy6(), 420.5 * layoutBy6(), 60 * layoutBy6(), 14.5 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(J_SCREEN_WIDTH/2 - 150/2 * layoutBy6(), 251 * layoutBy6(), 150 * layoutBy6(), 18.5 * layoutBy6());
}

-(void)didClickOpenBtn {
    if (self.openBtnCallback) {
        self.openBtnCallback(@(1));
    }
}

-(void)didClickCloseBtn {
    if (self.closeBtnCallback) {
        self.closeBtnCallback(@(1));
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"000000");
        _bgView.alpha = 0.3;
    }
    return _bgView;
}

-(UIImageView *)hongbaoView {
    if (!_hongbaoView) {
        _hongbaoView = [[UIImageView alloc] init];
        _hongbaoView.image = [UIImage imageNamed:@"icon-hognbao-k"];
    }
    return _hongbaoView;
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"恭喜获得5个积分";
        _tipsLbl.textColor = hexStringToColor(@"ffedb9");
        _tipsLbl.font = [UIFont systemFontOfSize:19 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLbl;
}

-(UILabel *)openLbl {
    if (!_openLbl) {
        _openLbl = [[UILabel alloc] init];
        NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
        NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:@"查看积分" attributes:attribtDic];
        _openLbl.attributedText = attribtStr;
//        _openLbl.text = @"查看积分";
        _openLbl.textColor = hexStringToColor(@"fe5553");
        _openLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _openLbl.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickOpenBtn)];
        [_openLbl addGestureRecognizer:tap];
        _openLbl.userInteractionEnabled = YES;
    }
    return _openLbl;
}

-(UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] init];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"icon-guanbi"] forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(didClickCloseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
