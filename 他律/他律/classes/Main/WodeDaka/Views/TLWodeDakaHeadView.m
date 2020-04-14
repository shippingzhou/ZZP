//
//  TLWodeDakaHeadView.m
//  他律
//
//  Created by sineboy on 2019/12/24.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLWodeDakaHeadView.h"
#import <objc/runtime.h>

@interface TLWodeDakaHeadView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *tittleLbl;

@property (nonatomic, strong) UIButton *addJihuaBtn;

@property (nonatomic, strong) UITextField *searchField;

@end

@implementation TLWodeDakaHeadView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.tittleLbl];
    [self addSubview:self.addJihuaBtn];
    [self addSubview:self.searchField];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 107 * layoutBy6());
    self.tittleLbl.frame = CGRectMake(J_SCREEN_WIDTH/2 - 80/2 * layoutBy6(), 33 * layoutBy6(), 80 * layoutBy6(), 16 * layoutBy6());
    self.addJihuaBtn.frame = CGRectMake(J_SCREEN_WIDTH - 12 * layoutBy6() - 70 * layoutBy6(), 34 * layoutBy6(), 70 * layoutBy6(), 14 * layoutBy6());
    self.searchField.frame = CGRectMake(15 * layoutBy6(), 70 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 30 * layoutBy6());
}

-(void)didClickAddBtn {
    if (self.addBtnCallback) {
        self.addBtnCallback(@(1));
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UILabel *)tittleLbl {
    if (!_tittleLbl) {
        _tittleLbl = [[UILabel alloc] init];
        _tittleLbl.text = @"我的打卡";
        _tittleLbl.textColor = hexStringToColor(@"333333");
        _tittleLbl.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        _tittleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tittleLbl;
}

-(UIButton *)addJihuaBtn {
    if (!_addJihuaBtn) {
        _addJihuaBtn = [[UIButton alloc] init];
        [_addJihuaBtn setTitle:@"新建计划" forState:UIControlStateNormal];
        [_addJihuaBtn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateNormal];
        _addJihuaBtn.titleLabel.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        [_addJihuaBtn addTarget:self action:@selector(didClickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addJihuaBtn;
}

-(UITextField *)searchField {
    if (!_searchField) {
        _searchField = [[UITextField alloc] init];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,10, 0)];
        _searchField.leftView = paddingView;
        _searchField.leftViewMode = UITextFieldViewModeAlways;
        _searchField.layer.cornerRadius = 5;
        _searchField.layer.masksToBounds = YES;
        _searchField.backgroundColor = hexStringToColor(@"f5f7fb");
        _searchField.placeholder = @"大家在搜：阅读";
        _searchField.textColor = hexStringToColor(@"999999");
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_searchField, ivar);
        placeholderLabel.textColor = hexStringToColor(@"999999");
        placeholderLabel.alpha = 0.7;
//        [_searchField setValue:hexStringToColor(@"999999") forKeyPath:@"_placeholderLabel.textColor"];
//        [_searchField setValue:@(0.7) forKeyPath:@"_placeholderLabel.alpha"];
        _searchField.keyboardType = UIKeyboardTypeASCIICapable;
        _searchField.delegate = self;
        _searchField.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        _searchField.tag = 10;
    }
    return _searchField;
}

@end
