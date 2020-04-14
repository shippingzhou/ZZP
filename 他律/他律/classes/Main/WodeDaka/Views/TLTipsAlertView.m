//
//  TLTipsAlertView.m
//  他律
//
//  Created by sineboy on 2020/4/1.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLTipsAlertView.h"

@interface TLTipsAlertView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *tittleLbl;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancelBtn;

@property (nonatomic, strong) UIButton *confirmBtn;

@end

@implementation TLTipsAlertView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.coverView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.tittleLbl];
    [self.bgView addSubview:self.lineView];
    [self.bgView addSubview:self.cancelBtn];
    [self.bgView addSubview:self.confirmBtn];
    [self makeSubViewsContraint];
}

-(void)makeSubViewsContraint {

    CGFloat width = (J_SCREEN_WIDTH - 60 * layoutBy6())/2;
    
    self.coverView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
    self.bgView.frame = CGRectMake(28 * layoutBy6(), 239 * layoutBy6(), J_SCREEN_WIDTH - 56 * layoutBy6(), 169 * layoutBy6());
    self.tittleLbl.frame = CGRectMake(20 * layoutBy6(), 45 * layoutBy6(), self.bgView.width - 40 * layoutBy6(), 42 * layoutBy6());
    self.lineView.frame = CGRectMake(0, 113.5 * layoutBy6(), self.bgView.width, 0.5);
    self.cancelBtn.frame = CGRectMake(0, self.lineView.bottom, width, 50 * layoutBy6());
    self.confirmBtn.frame = CGRectMake(self.cancelBtn.right, self.cancelBtn.top, width, 50 * layoutBy6());
}

-(void)setTags:(NSString *)tags {
    _tags = tags;
    CGFloat width = (J_SCREEN_WIDTH - 60 * layoutBy6())/2;
    CGFloat btnleft;
    if ([tags isEqualToString:@"1"]) {
        self.tittleLbl.text = @"您尚有正在执行的计划，建议您一次专注培养一个习惯";
        self.confirmBtn.hidden = NO;
        btnleft = 0;
    }else if ([tags isEqualToString:@"2"]) {
        self.tittleLbl.text = @"改变自己非一日之功，重在坚持，您已有两个正在执行的计划，先完成它们吧";
        self.confirmBtn.hidden = YES;
        btnleft = width/2;
    }
    self.cancelBtn.left = btnleft;
}

-(void)didClickConfirmBtn {
    if (self.confirmBtnCallback) {
        self.confirmBtnCallback(@(1));
    }
}

-(void)didClickCancelBtn {
    if (self.cancelBtnCallback) {
        self.cancelBtnCallback(@(1));
    }
}

-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = hexStringToColor(@"1e0f02");
        _coverView.alpha = 0.5;
    }
    return _coverView;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
        _bgView.layer.cornerRadius = 5 * layoutBy6();
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)tittleLbl {
    if (!_tittleLbl) {
        _tittleLbl = [[UILabel alloc] init];
        _tittleLbl.textColor = hexStringToColor(@"333333");
        _tittleLbl.font = [UIFont systemFontOfSize:16 * layoutBy6()];
        _tittleLbl.textAlignment = NSTextAlignmentCenter;
        _tittleLbl.numberOfLines = 0;
    }
    return _tittleLbl;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = hexStringToColor(@"e9e9e9");
    }
    return _lineView;
}

-(UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc] init];
        [_cancelBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:hexStringToColor(@"808080") forState:UIControlStateNormal];
        _cancelBtn.titleLabel.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        [_cancelBtn addTarget:self action:@selector(didClickCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

-(UIButton *)confirmBtn {
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc] init];
        [_confirmBtn setTitle:@"两个没压力" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateNormal];
        _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        [_confirmBtn addTarget:self action:@selector(didClickConfirmBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}

@end
