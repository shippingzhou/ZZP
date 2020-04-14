//
//  TLPersonalEditVC.m
//  他律
//
//  Created by sineboy on 2019/12/25.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLPersonalEditVC.h"
#import "TLChangeImageVVC.h"

@interface TLPersonalEditVC ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *headLbl;

@property (nonatomic, strong) UIImageView *headView;

@property (nonatomic, strong) UILabel *nameText;

@property (nonatomic, strong) UITextField *nameField;

@property (nonatomic, strong) UILabel *signText;

@property (nonatomic, strong) UITextField *signField;

@end

@implementation TLPersonalEditVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    self.title = @"编辑个人资料";
    [self creatLeftEnble];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.bgView];
//    [self.view addSubview:self.leftBtn];
//    [self.view addSubview:self.titleLbl];
    [self.view addSubview:self.headLbl];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.nameText];
    [self.view addSubview:self.nameField];
    [self.view addSubview:self.signText];
    [self.view addSubview:self.signField];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.bgView.frame = CGRectMake(0, J_StatusBarAndNavBarHeight, J_SCREEN_WIDTH, 150 * layoutBy6());
    self.leftBtn.frame = CGRectMake(15 * layoutBy6(), 33 * layoutBy6(), 8.5 * layoutBy6(), 16.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(50 * layoutBy6(), 33 * layoutBy6(), J_SCREEN_WIDTH - 100 * layoutBy6(), 16 * layoutBy6());
    self.headLbl.frame = CGRectMake(15 * layoutBy6(), 81 * layoutBy6(), 100 * layoutBy6(), 14 * layoutBy6());
    self.headView.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 50 * layoutBy6(), 61.5 * layoutBy6(), 50 * layoutBy6(), 50 * layoutBy6());
    self.nameText.frame = CGRectMake(self.headLbl.left, self.headLbl.bottom + 35 * layoutBy6(), 100 * layoutBy6(), 14 * layoutBy6());
    self.nameField.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 200 * layoutBy6(), self.nameText.top, 200 * layoutBy6(), 14 * layoutBy6());
    self.signText.frame = CGRectMake(15 * layoutBy6(), self.nameText.bottom + 35 * layoutBy6(), 100 * layoutBy6(), 14 * layoutBy6());
    self.signField.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 200 * layoutBy6(), self.signText.top, 200 * layoutBy6(), 14 * layoutBy6());
}

-(void)didClickLeftBtn {
    K_userInfo.name = self.nameField.text;
    K_userInfo.signature = self.signField.text;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickHeadView:(UITapGestureRecognizer *)tap {
    TLChangeImageVVC *vc = [[TLChangeImageVVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(didClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"编辑个人资料";
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

-(UILabel *)headLbl {
    if (!_headLbl) {
        _headLbl = [[UILabel alloc] init];
        _headLbl.text = @"头像";
        _headLbl.textColor = hexStringToColor(@"333333");
        _headLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _headLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _headLbl;
}

-(UIImageView *)headView {
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.layer.cornerRadius = 25 * layoutBy6();
        _headView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickHeadView:)];
        [_headView addGestureRecognizer:tap];
        _headView.userInteractionEnabled = YES;
    }
    return _headView;
}

-(UILabel *)nameText {
    if (!_nameText) {
        _nameText = [[UILabel alloc] init];
        _nameText.text = @"昵称";
        _nameText.textColor = hexStringToColor(@"333333");
        _nameText.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _nameText.textAlignment = NSTextAlignmentLeft;
    }
    return _nameText;
}

-(UILabel *)signText {
    if (!_signText) {
        _signText = [[UILabel alloc] init];
        _signText.text = @"签名";
        _signText.textColor = hexStringToColor(@"333333");
        _signText.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _signText.textAlignment = NSTextAlignmentLeft;
    }
    return _signText;
}

-(UITextField *)nameField {
    if (!_nameField) {
        _nameField = [[UITextField alloc] init];
        _nameField.text = K_userInfo.name;
        _nameField.textColor = hexStringToColor(@"666666");
        _nameField.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _nameField.textAlignment = NSTextAlignmentRight;
    }
    return _nameField;
}

-(UITextField *)signField {
    if (!_signField) {
        _signField = [[UITextField alloc] init];
        _signField.text = K_userInfo.signature;
        _signField.textColor = hexStringToColor(@"666666");
        _signField.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _signField.textAlignment = NSTextAlignmentRight;
    }
    return _signField;
}


@end
