//
//  TLHongbaoWeidakaiView.m
//  他律
//
//  Created by sineboy on 2019/12/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLHongbaoWeidakaiView.h"

@interface TLHongbaoWeidakaiView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *hongbaoView;

@property (nonatomic, strong) UIButton *openBtn;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *closeBtn;

@end

@implementation TLHongbaoWeidakaiView

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
    [self addSubview:self.openBtn];
    [self addSubview:self.tipsLbl];
    [self addSubview:self.closeBtn];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
    self.hongbaoView.frame = CGRectMake(36 * layoutBy6(), 163 * layoutBy6(), 302 * layoutBy6(), 397 * layoutBy6());
    self.closeBtn.frame = CGRectMake(J_SCREEN_WIDTH - 45.5 * layoutBy6() - 26 * layoutBy6(), 115.5 * layoutBy6(), 26 * layoutBy6(), 26 * layoutBy6());
    self.openBtn.frame = CGRectMake(142 * layoutBy6(), self.hongbaoView.top + 61 * layoutBy6(), 90 * layoutBy6(), 90 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(J_SCREEN_WIDTH/2 - 160/2 * layoutBy6(), 377 * layoutBy6(), 160 * layoutBy6(), 50 * layoutBy6());
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
        _hongbaoView.image = [UIImage imageNamed:@"iocn-hongbao"];
    }
    return _hongbaoView;
}

-(UIButton *)openBtn {
    if (!_openBtn) {
        _openBtn = [[UIButton alloc] init];
        [_openBtn addTarget:self action:@selector(didClickOpenBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _openBtn;
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"生活处处充满彩蛋\n越努力，越幸运！";
        _tipsLbl.textColor = hexStringToColor(@"ffedb9");
        _tipsLbl.font = [UIFont systemFontOfSize:19 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
        _tipsLbl.numberOfLines = 2;
    }
    return _tipsLbl;
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
