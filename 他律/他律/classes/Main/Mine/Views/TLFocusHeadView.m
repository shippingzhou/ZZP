//
//  TLFocusHeadView.m
//  他律
//
//  Created by sineboy on 2020/2/27.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLFocusHeadView.h"

@interface TLFocusHeadView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *myFocusBtn;

@property (nonatomic, strong) UIButton *focusMeBtn;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIView *underLine;

@end

@implementation TLFocusHeadView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.leftBtn];
    [self addSubview:self.myFocusBtn];
    [self addSubview:self.focusMeBtn];
    [self addSubview:self.searchField];
    [self addSubview:self.lineView];
    [self addSubview:self.tipsLbl];
    [self addSubview:self.underLine];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.leftBtn.frame = CGRectMake(15 * layoutBy6(), 32.25 * layoutBy6(), 8.5 * layoutBy6(), 16.5 * layoutBy6());
    self.myFocusBtn.frame = CGRectMake(118.5 * layoutBy6(), 33.5 * layoutBy6(), 60 * layoutBy6(), 14 * layoutBy6());
    self.focusMeBtn.frame = CGRectMake(self.myFocusBtn.left + 21 * layoutBy6(), self.myFocusBtn.top, self.myFocusBtn.width, self.myFocusBtn.height);
    self.searchField.frame = CGRectMake(15 * layoutBy6(), 73 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 30 * layoutBy6());
    self.lineView.frame = CGRectMake(0, self.searchField.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH, 10 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(10.5 * layoutBy6(), self.lineView.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 21 * layoutBy6(), 10 * layoutBy6());
    self.underLine.frame = CGRectMake(0, self.tipsLbl.bottom + 10 * layoutBy6() - 0.5, J_SCREEN_WIDTH, 0.5);
}

-(void)didClickLeftBtn {
    
}

-(void)didClickTitleBtn:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(didClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UIButton *)myFocusBtn {
    if (!_myFocusBtn) {
        _myFocusBtn = [[UIButton alloc] init];
        [_myFocusBtn setTitle:@"我的关注" forState:UIControlStateNormal];
        [_myFocusBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        [_myFocusBtn setTitleColor:RGBA(38, 194, 57, 1) forState:UIControlStateSelected];
        self.selectedBtn = _myFocusBtn;
        self.selectedBtn.selected = YES;
        [_myFocusBtn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _myFocusBtn;
}

-(UIButton *)focusMeBtn {
    if (!_focusMeBtn) {
        _focusMeBtn = [[UIButton alloc] init];
        [_focusMeBtn setTitle:@"关注我的" forState:UIControlStateNormal];
        [_focusMeBtn setTitleColor:RGBA(51, 51, 51, 1) forState:UIControlStateNormal];
        [_focusMeBtn setTitleColor:RGBA(38, 194, 57, 1) forState:UIControlStateSelected];
        [_focusMeBtn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusMeBtn;
}

-(UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] init];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15 * layoutBy6(), 0)];
        _searchField.leftView = paddingView;
        _searchField.leftViewMode = UITextFieldViewModeAlways;
        _searchField.layer.cornerRadius = 10 * layoutBy6();
        _searchField.layer.masksToBounds = YES;
        _searchField.backgroundColor = hexStringToColor(@"f5f7fb");
        _searchField.placeholder = @"搜索";
        _searchField.textColor = hexStringToColor(@"1e0f02");
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_searchField, ivar);
        placeholderLabel.textColor = RGBA(153, 153, 153, 1);
        _searchField.keyboardType = UIKeyboardTypeASCIICapable;
        _searchField.delegate = self;
        _searchField.font = [UIFont systemFontOfSize:15 * layoutBy6()];
    }
    return _searchField;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = hexStringToColor(@"f5f7fb");
    }
    return _lineView;
}

@end
