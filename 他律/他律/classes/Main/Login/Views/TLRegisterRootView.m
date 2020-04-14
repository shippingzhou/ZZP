//
//  TLRegisterRootView.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLRegisterRootView.h"
#import <objc/runtime.h>

@interface TLRegisterRootView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *topView;

@property (nonatomic, strong) UIImageView *bgView; //

@property (nonatomic, strong) UILabel *registText; //

@property (nonatomic, strong) UILabel *accountText; //

@property (nonatomic, strong) UIView *accountUnderLine; //

@property (nonatomic, strong) UILabel *passwordText; //

@property (nonatomic, strong) UIView *passwordUnderLine; //

@property (nonatomic, strong) UILabel *readLbl;

@property (nonatomic, strong) UILabel *zhongjianLbl;

@end

@implementation TLRegisterRootView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.registText];
    [self addSubview:self.accountText];
    [self addSubview:self.zhanghaoField];
    [self addSubview:self.accountUnderLine];
    [self addSubview:self.passwordText];
    [self addSubview:self.passwordField];
    [self addSubview:self.passwordUnderLine];
    [self addSubview:self.readLbl];
    [self addSubview:self.yingsiLbl];
    [self addSubview:self.zhongjianLbl];
    [self addSubview:self.xieyiLbl];
    [self addSubview:self.registBtn];
    [self addSubview:self.leftBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = self.bounds;
    
    self.registText.frame = CGRectMake(J_SCREEN_WIDTH/2 - 250/2, J_StatusBarHeight + 10, 250, 40);
    
    self.accountText.frame = CGRectMake(15, self.registText.bottom + 50, 120, 20);
    self.zhanghaoField.frame = CGRectMake(self.accountText.left, self.accountText.bottom + 20, 300, 15);
    self.accountUnderLine.frame = CGRectMake(15, self.zhanghaoField.bottom + 10, J_SCREEN_WIDTH - 30, 2);
    self.passwordText.frame = CGRectMake(15, self.accountUnderLine.bottom + 25, 80, 20);
    self.passwordField.frame = CGRectMake(self.passwordText.left, self.passwordText.bottom + 20, 300, 15);
    self.passwordUnderLine.frame = CGRectMake(15, self.passwordField.bottom + 10, J_SCREEN_WIDTH - 30, 2);
    self.readLbl.frame = CGRectMake(50, self.passwordUnderLine.bottom + 40, J_SCREEN_WIDTH - 100, 20);
    self.yingsiLbl.frame = CGRectMake(30, self.readLbl.bottom + 20, 120, 20);
    self.zhongjianLbl.frame = CGRectMake(self.yingsiLbl.right, self.yingsiLbl.top, 40, 20);
    self.xieyiLbl.frame = CGRectMake(self.zhongjianLbl.right, self.yingsiLbl.top, 200, 20);
    
    self.registBtn.frame = CGRectMake(J_SCREEN_WIDTH/2 - 250/2, self.passwordUnderLine.bottom + 150, 250, 50);
    self.leftBtn.frame = CGRectMake(10, J_StatusBarHeight + 10, 20, 30);
}

-(void)clickbtn:(UIButton *)btn {
    btn.selected = !btn.selected;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.zhanghaoField endEditing:YES];
    [self.passwordField endEditing:YES];
}

-(UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    }
    return _leftBtn;
}


-(UILabel *)registText {
    if (!_registText) {
        _registText = [[UILabel alloc] init];
        _registText.text = @"Registration";
        _registText.textColor = hexStringToColor(login_color);
        _registText.font = [UIFont fontWithName:K_BoldMT size:30];
        _registText.textAlignment = NSTextAlignmentCenter;
    }
    return _registText;
}


-(UILabel *)accountText {
    if (!_accountText) {
        _accountText = [[UILabel alloc] init];
        _accountText.text = @"Username";
        _accountText.textColor = hexStringToColor(login_color);
        _accountText.font = [UIFont systemFontOfSize:18];
        _accountText.alpha = 1;
    }
    return _accountText;
}

-(UITextField *)zhanghaoField {
    if (!_zhanghaoField) {
        _zhanghaoField = [[UITextField alloc] init];
        _zhanghaoField.placeholder = @"Enter your username";
        _zhanghaoField.textColor = hexStringToColor(login_color);
        Ivar ivar =  class_getInstanceVariable([UITextField class], "_placeholderLabel");
        UILabel *placeholderLabel = object_getIvar(_zhanghaoField, ivar);
        placeholderLabel.textColor = hexStringToColor(login_color);
        placeholderLabel.alpha = 0.7;
//        [_zhanghaoField setValue:hexStringToColor(login_color) forKeyPath:@"_placeholderLabel.textColor"];
//        [_zhanghaoField setValue:@(0.7) forKeyPath:@"_placeholderLabel.alpha"];
        _zhanghaoField.keyboardType = UIKeyboardTypeASCIICapable;
        _zhanghaoField.delegate = self;
        _zhanghaoField.font = [UIFont systemFontOfSize:15];
        _zhanghaoField.tag = 10;
    }
    return _zhanghaoField;
}

-(UIView *)accountUnderLine {
    if (!_accountUnderLine) {
        _accountUnderLine = [[UIView alloc] init];
        _accountUnderLine.backgroundColor = hexStringToColor(login_color);
        _accountUnderLine.alpha = 0.7;
    }
    return _accountUnderLine;
}

-(UILabel *)passwordText {
    if (!_passwordText) {
        _passwordText = [[UILabel alloc] init];
        _passwordText.text = @"Password";
        _passwordText.textColor = hexStringToColor(login_color);
        _passwordText.font = [UIFont systemFontOfSize:18];
        _passwordText.alpha = 1;
    }
    return _passwordText;
}

-(UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [[UITextField alloc] init];
        _passwordField.placeholder = @"Enter your password";
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

-(UIView *)passwordUnderLine {
    if (!_passwordUnderLine) {
        _passwordUnderLine = [[UIView alloc] init];
        _passwordUnderLine.backgroundColor = hexStringToColor(login_color);
        _passwordUnderLine.alpha = 0.7;
    }
    return _passwordUnderLine;
}

-(UIButton *)registBtn {
    if (!_registBtn) {
        _registBtn = [[UIButton alloc] init];
        _registBtn.backgroundColor = hexStringToColor(login_color);
        [_registBtn setTitle:@"register" forState:UIControlStateNormal];
        _registBtn.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
        _registBtn.layer.borderWidth = 0.5;
        _registBtn.layer.cornerRadius = 5;
        _registBtn.layer.masksToBounds = YES;
        [_registBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _registBtn.titleLabel.font = [UIFont systemFontOfSize:25];
    }
    return _registBtn;
}

-(UILabel *)yingsiLbl {
    if (!_yingsiLbl) {
        _yingsiLbl = [[UILabel alloc] init];
        _yingsiLbl.text = @"<Privacy Policy>";
        _yingsiLbl.textColor = hexStringToColor(@"CC6633");
        _yingsiLbl.font = [UIFont systemFontOfSize:14];
    }
    return _yingsiLbl;
}

-(UILabel *)zhongjianLbl {
    if (!_zhongjianLbl) {
        _zhongjianLbl = [[UILabel alloc] init];
        _zhongjianLbl.text = @"And";
        _zhongjianLbl.textColor = hexStringToColor(login_color);
        _zhongjianLbl.font = [UIFont systemFontOfSize:14];
    }
    return _zhongjianLbl;
}

-(UILabel *)xieyiLbl {
    if (!_xieyiLbl) {
        _xieyiLbl = [[UILabel alloc] init];
        _xieyiLbl.text = @"<User license agreement>";
        _xieyiLbl.textColor = hexStringToColor(@"CC6633");
        _xieyiLbl.font = [UIFont systemFontOfSize:14];
        _xieyiLbl.tag = 20;
    }
    return _xieyiLbl;
}

-(UILabel *)readLbl {
    if (!_readLbl) {
        _readLbl = [[UILabel alloc] init];
        _readLbl.text = @"Registration means consent";
        _readLbl.textColor = hexStringToColor(login_color);
        _readLbl.font = [UIFont systemFontOfSize:14];
        _readLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _readLbl;
}

@end
