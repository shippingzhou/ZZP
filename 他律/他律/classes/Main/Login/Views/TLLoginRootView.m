//
//  TLLoginRootView.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLoginRootView.h"
#import <objc/runtime.h>

@interface TLLoginRootView()<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *topView;

@property (nonatomic, strong) UILabel *appNameText; //

@property (nonatomic, strong) UILabel *getCodeText; //

@property (nonatomic, strong) UILabel *tipsText; //

@end

@implementation TLLoginRootView

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
    [self addSubview:self.accountField];
    [self addSubview:self.passwordField];
    [self addSubview:self.loginBtn];
    [self addSubview:self.getCodeBtn];
    [self addSubview:self.getCodeText];
    [self addSubview:self.tipsText];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.topView.frame = CGRectMake(J_SCREEN_WIDTH/2 - (73/2) * layoutBy6(), 77 * layoutBy6(), 73 * layoutBy6(), 64.5 * layoutBy6());
    self.appNameText.frame = CGRectMake(0, self.topView.bottom +  6.5 * layoutBy6(), J_SCREEN_WIDTH, 20 * layoutBy6());
    self.accountField.frame = CGRectMake(25 * layoutBy6(), 221 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
    self.passwordField.frame = CGRectMake(self.accountField.left, self.accountField.bottom + 20 * layoutBy6(), self.accountField.width, self.accountField.height);
    self.getCodeBtn.frame = CGRectMake(self.passwordField.right - 90 * layoutBy6(), self.passwordField.top, 90 * layoutBy6(), self.passwordField.height);
    self.getCodeText.frame = CGRectMake(J_SCREEN_WIDTH - 25 * layoutBy6() - 300 * layoutBy6(), self.getCodeBtn.bottom + 15 * layoutBy6(), 300 * layoutBy6(), 12.5 * layoutBy6());
    self.loginBtn.frame = CGRectMake(self.accountField.left, 417 * layoutBy6(), self.accountField.width, 50 * layoutBy6());
    self.tipsText.frame = CGRectMake(0 , J_SCREEN_HEIGHT - 12 * layoutBy6() - 18 * layoutBy6(), J_SCREEN_WIDTH, 18 * layoutBy6());
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.accountField endEditing:YES];
    [self.passwordField endEditing:YES];
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

-(UITextField *)accountField {
    if (!_accountField) {
        _accountField = [[UITextField alloc] init];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15, 0)];
        _accountField.leftView = paddingView;
        _accountField.leftViewMode = UITextFieldViewModeAlways;
        _accountField.layer.cornerRadius = 10;
        _accountField.layer.masksToBounds = YES;
        _accountField.backgroundColor = hexStringToColor(@"f5f7fb");
        _accountField.placeholder = @"请输入您的手机号码";
        _accountField.textColor = hexStringToColor(login_color);
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_accountField, ivar);
        placeholderLabel.textColor = hexStringToColor(login_color);
        placeholderLabel.alpha = 0.7;
//        [_accountField setValue:hexStringToColor(login_color) forKeyPath:@"_placeholderLabel.textColor"];
//        [_accountField setValue:@(0.7) forKeyPath:@"_placeholderLabel.alpha"];
        _accountField.keyboardType = UIKeyboardTypeASCIICapable;
        _accountField.delegate = self;
        _accountField.font = [UIFont systemFontOfSize:15];
        _accountField.tag = 10;
    }
    return _accountField;
}


-(UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,15, 0)];
        _passwordField.leftView = paddingView;
        _passwordField.leftViewMode = UITextFieldViewModeAlways;
        _passwordField.layer.cornerRadius = 10;
        _passwordField.layer.masksToBounds = YES;
        _passwordField.backgroundColor = hexStringToColor(@"f5f7fb");
        _passwordField.placeholder = @"请输入验证码";
        _passwordField.textColor = hexStringToColor(login_color);
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_passwordField, ivar);
        placeholderLabel.textColor = hexStringToColor(login_color);
        placeholderLabel.alpha = 0.7;
//        [_passwordField setValue:hexStringToColor(login_color) forKeyPath:@"_placeholderLabel.textColor"];
//        [_passwordField setValue:@(0.7) forKeyPath:@"_placeholderLabel.alpha"];
        _passwordField.clearsOnBeginEditing = YES;
        _passwordField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordField.secureTextEntry = YES;
        _passwordField.delegate = self;
        _passwordField.font = [UIFont systemFontOfSize:15];
        _passwordField.tag = 20;
    }
    return _passwordField;
}

-(UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] init];
        _loginBtn.backgroundColor = hexStringToColor(@"24d64e");
        _loginBtn.layer.cornerRadius = 10;
        _loginBtn.layer.masksToBounds = YES;
        
        [_loginBtn setTitle:@"注册/登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        _loginBtn.tag = 10;
    }
    return _loginBtn;
}

-(TLVerifyCodeBtn *)getCodeBtn {
    if (!_getCodeBtn) {
        _getCodeBtn = [[TLVerifyCodeBtn alloc] init];
//        _getCodeBtn.backgroundColor = hexStringToColor(@"24d64e");
//        _getCodeBtn.layer.cornerRadius = 10;
//        _getCodeBtn.layer.masksToBounds = YES;
        CAShapeLayer*maskLayer = [CAShapeLayer layer];
        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, 90 * layoutBy6(), 50 * layoutBy6()) byRoundingCorners:UIRectCornerTopRight|UIRectCornerBottomRight cornerRadii: (CGSize){10.0f,10.0f}].CGPath;
        _getCodeBtn.layer.masksToBounds =YES;
        _getCodeBtn.layer.mask = maskLayer;
//        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//        [_getCodeBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
//        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _getCodeBtn.tag = 20;
    }
    return _getCodeBtn;
}

-(UILabel *)getCodeText {
    if (!_getCodeText) {
        _getCodeText = [[UILabel alloc] init];
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] init];
        NSAttributedString * rgStr1 = [[NSAttributedString alloc] initWithString:@"收不到短信，获取" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:hexStringToColor(@"666666")}];
        NSAttributedString * rgStr2 = [[NSAttributedString alloc] initWithString:@"语言验证码" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:hexStringToColor(@"24d64e")}];
        
        [attStr appendAttributedString:rgStr1];
        [attStr appendAttributedString:rgStr2];
        _getCodeText.attributedText = attStr;
//        _getCodeText.textColor = hexStringToColor(@"666666");
//        _getCodeText.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _getCodeText.textAlignment = NSTextAlignmentRight;
    }
    return _getCodeText;
}

-(UILabel *)tipsText {
    if (!_tipsText) {
        _tipsText = [[UILabel alloc] init];
        _tipsText.text = @"如您尚未注册，则您点击登录后即为您自动注册账号";
        _tipsText.textColor = hexStringToColor(@"808080");
        _tipsText.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _tipsText.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsText;
}


@end
