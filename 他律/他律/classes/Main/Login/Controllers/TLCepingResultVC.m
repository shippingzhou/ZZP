//
//  TLCepingResultVC.m
//  他律
//
//  Created by sineboy on 2019/12/15.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLCepingResultVC.h"
#import "UIImage+Utility.h"

@interface TLCepingResultVC ()

@property (nonatomic, strong) UIImageView *bgView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *raleLbl;

@property (nonatomic, strong) UILabel *resultTitle;

@property (nonatomic, strong) UILabel *resultTextLbl;

@property (nonatomic, strong) UIButton *startBtn;

@end

@implementation TLCepingResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = hexStringToColor(@"ffffff");
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.bgView];
    [self.view addSubview:self.leftBtn];
    [self.view addSubview:self.titleLbl];
    [self.view addSubview:self.raleLbl];
    [self.view addSubview:self.resultTitle];
    [self.view addSubview:self.resultTextLbl];
    [self.view addSubview:self.startBtn];
    [self makeSubViewContraints];
}

-(void)makeSubViewContraints {
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 285 * layoutBy6());
    self.leftBtn.frame = CGRectMake(15 * layoutBy6(), 33 * layoutBy6(), 16.5 * layoutBy6(), 16.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(100 * layoutBy6(), 33 * layoutBy6(), J_SCREEN_WIDTH - 200 * layoutBy6(), 16.5 * layoutBy6());
    self.raleLbl.frame = CGRectMake(0, 130 * layoutBy6(), J_SCREEN_WIDTH, 55 * layoutBy6());
    self.resultTitle.frame = CGRectMake(0, 390 * layoutBy6(), J_SCREEN_WIDTH, 15 * layoutBy6());
    self.resultTextLbl.frame = CGRectMake(0, self.resultTitle.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH, 15 * layoutBy6());
    self.startBtn.frame = CGRectMake(25 * layoutBy6(), 542.5 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
}

-(void)didClickNextBtn:(UIButton *)btn {
    
}

-(void)didClickLeftBtn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIImageView *)bgView {
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.image = [UIImage imageNamed:@"cepingjieguo"];
    }
    return _bgView;
}

- (UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui_white"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(didClickLeftBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"测评结果";
        _titleLbl.textColor = hexStringToColor(@"ffffff");
        _titleLbl.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

-(UILabel *)raleLbl {
    if (!_raleLbl) {
        _raleLbl = [[UILabel alloc] init];
        _raleLbl.text = [NSString stringWithFormat:@"%.0f%@",K_userInfo.allFenshu,@"分"];
        _raleLbl.textColor = hexStringToColor(@"ffffff");
        _raleLbl.font = [UIFont systemFontOfSize:74 * layoutBy6()];
        _raleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _raleLbl;
}

-(UILabel *)resultTitle {
    if (!_resultTitle) {
        _resultTitle = [[UILabel alloc] init];
        _resultTitle.text = @"根据测评结果";
        _resultTitle.textColor = hexStringToColor(@"be8330");
        _resultTitle.font = [UIFont systemFontOfSize:17 * layoutBy6()];
        _resultTitle.textAlignment = NSTextAlignmentCenter;
    }
    return _resultTitle;
}

-(UILabel *)resultTextLbl {
    if (!_resultTextLbl) {
        _resultTextLbl = [[UILabel alloc] init];
        _resultTextLbl.text = [NSString stringWithFormat:@"您通过他律APP改变自己的成功率为%@%@",@"98",@"%"];
        _resultTextLbl.textColor = hexStringToColor(@"666666");
        _resultTextLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _resultTextLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _resultTextLbl;
}

-(UIButton *)startBtn {
    if (!_startBtn) {
        _startBtn = [[UIButton alloc] init];
        _startBtn.layer.cornerRadius = 10;
        _startBtn.layer.masksToBounds = YES;
        UIColor *topleftColor = hexStringToColor(@"24d64e");
        UIColor *bottomrightColor = hexStringToColor(@"2eba59");
        CGSize size = CGSizeMake(J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [_startBtn setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        [_startBtn setTitle:@"立即开始体验" forState:UIControlStateNormal];
        [_startBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _startBtn.titleLabel.font = [UIFont systemFontOfSize:18 * layoutBy6()];
        [_startBtn addTarget:self action:@selector(didClickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _startBtn;
}

@end
