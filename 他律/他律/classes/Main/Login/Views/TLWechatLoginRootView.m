//
//  TLWechatLoginRootView.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLWechatLoginRootView.h"

@interface TLWechatLoginRootView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *topView;

@property (nonatomic, strong) UILabel *appNameText; //

@property (nonatomic, strong) UILabel *xieyiText; //

@end

@implementation TLWechatLoginRootView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.topView];
    [self addSubview:self.appNameText];
    [self addSubview:self.loginBtn];
    [self addSubview:self.moreLoginBtn];
    [self addSubview:self.xieyiText];
    [self addSubview:self.fuwuxieyiBtn];
    [self addSubview:self.yisishengmingBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.topView.frame = CGRectMake(J_SCREEN_WIDTH/2 - (73/2) * layoutBy6(), 119 * layoutBy6(), 73 * layoutBy6(), 64.5 * layoutBy6());
    self.appNameText.frame = CGRectMake(0, self.topView.bottom +  6.5 * layoutBy6(), J_SCREEN_WIDTH, 20 * layoutBy6());
    
    self.loginBtn.frame = CGRectMake(25 * layoutBy6(), 474 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
    self.xieyiText.frame = CGRectMake(25 * layoutBy6(), self.loginBtn.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 12.5 * layoutBy6());
    self.fuwuxieyiBtn.frame = CGRectMake(130 * layoutBy6(), self.xieyiText.top - 5 * layoutBy6(), 95 * layoutBy6(), 22.5 * layoutBy6());
    self.yisishengmingBtn.frame = CGRectMake(self.fuwuxieyiBtn.right + 15 * layoutBy6(), self.fuwuxieyiBtn.top, 60 * layoutBy6(), self.fuwuxieyiBtn.height);
    self.moreLoginBtn.frame = CGRectMake(50 * layoutBy6(), J_SCREEN_HEIGHT - 18 * layoutBy6() - 20 * layoutBy6(), J_SCREEN_WIDTH - 100 * layoutBy6(), 20 * layoutBy6());
    
}

-(void)didClickXieyiBtn:(UITapGestureRecognizer *)tap {
    
}

-(UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] init];
        _topView.image = [UIImage imageNamed:@"icon-logo-"];
    }
    return _topView;
}

-(UILabel *)appNameText {
    if (!_appNameText) {
        _appNameText = [[UILabel alloc] init];
        _appNameText.text = @"他律";
        _appNameText.textColor = hexStringToColor(@"2ebb59");
        _appNameText.font = [UIFont fontWithName:K_BoldMT size:19];
        _appNameText.textAlignment = NSTextAlignmentCenter;
    }
    return _appNameText;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        _loginBtn.backgroundColor = hexStringToColor(@"24d64e");
        _loginBtn.layer.cornerRadius = 10;
        _loginBtn.layer.masksToBounds = YES;
        
        [_loginBtn setTitle:@"微信登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginBtn.tag = 10;
    }
    return _loginBtn;
}


-(UILabel *)xieyiText {
    if (!_xieyiText) {
        _xieyiText = [[UILabel alloc] init];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
        NSAttributedString * rgStr1 = [[NSAttributedString alloc] initWithString:@"已阅读并同意" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:hexStringToColor(@"666666")}];
        NSAttributedString * rgStr2 = [[NSAttributedString alloc] initWithString:@"《会员注册服务协议》" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:hexStringToColor(@"24d64e")}];
        NSAttributedString * rgStr3 = [[NSAttributedString alloc] initWithString:@"&" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:hexStringToColor(@"666666")}];
        NSAttributedString * rgStr4 = [[NSAttributedString alloc] initWithString:@"《隐私声明》" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10],NSForegroundColorAttributeName:hexStringToColor(@"24d64e")}];
        [attStr appendAttributedString:rgStr1];
        [attStr appendAttributedString:rgStr2];
        [attStr appendAttributedString:rgStr3];
        [attStr appendAttributedString:rgStr4];
        _xieyiText.attributedText = attStr;
        _xieyiText.textAlignment = NSTextAlignmentCenter;
    }
    return _xieyiText;
}

-(UIButton *)fuwuxieyiBtn {
    if (!_fuwuxieyiBtn) {
        _fuwuxieyiBtn = [[UIButton alloc] init];
        [_fuwuxieyiBtn setTitle:@"《会员注册服务协议》" forState:UIControlStateNormal];
        [_fuwuxieyiBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        _fuwuxieyiBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _fuwuxieyiBtn.tag = 10;
    }
    return _fuwuxieyiBtn;
}

-(UIButton *)yisishengmingBtn {
    if (!_yisishengmingBtn) {
        _yisishengmingBtn = [[UIButton alloc] init];
        [_yisishengmingBtn setTitle:@"《隐私声明》" forState:UIControlStateNormal];
        [_yisishengmingBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
        _yisishengmingBtn.titleLabel.font = [UIFont systemFontOfSize:10];
        _yisishengmingBtn.tag = 20;
    }
    return _yisishengmingBtn;
}

-(UIButton *)moreLoginBtn {
    if (!_moreLoginBtn) {
        _moreLoginBtn = [[UIButton alloc] init];
        [_moreLoginBtn setTitle:@"更多登录方式" forState:UIControlStateNormal];
        [_moreLoginBtn setTitleColor:hexStringToColor(@"666666") forState:UIControlStateNormal];
        _moreLoginBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _moreLoginBtn;
}

@end
