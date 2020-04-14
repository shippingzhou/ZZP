//
//  TLAboutUsVC.m
//  他律
//
//  Created by sineboy on 2020/2/27.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLAboutUsVC.h"

@interface TLAboutUsVC ()

@property (nonatomic, strong) UIImageView *logoView;

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UILabel *versionLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UILabel *compnyLbl;

@property (nonatomic, strong) UILabel *phoneLbl;

@end

@implementation TLAboutUsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatLeftEnble];
    self.title = @"关于";
    self.view.backgroundColor = hexStringToColor(@"ffffff");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.logoView];
    [self.view addSubview:self.nameLbl];
    [self.view addSubview:self.versionLbl];
    [self.view addSubview:self.tipsLbl];
    [self.view addSubview:self.compnyLbl];
    [self.view addSubview:self.phoneLbl];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.logoView.frame = CGRectMake(155.5 * layoutBy6(), 113.5 * layoutBy6(), 64 * layoutBy6(), 56.5 * layoutBy6());
    self.nameLbl.frame = CGRectMake(0, self.logoView.bottom + 29.5 * layoutBy6(), J_SCREEN_WIDTH, 22.5 * layoutBy6());
    self.versionLbl.frame = CGRectMake(0, self.nameLbl.bottom + 18.5 * layoutBy6(), J_SCREEN_WIDTH, 10 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(0, self.versionLbl.bottom + 10.5 * layoutBy6(), J_SCREEN_WIDTH, 9.5 * layoutBy6());
    self.phoneLbl.frame = CGRectMake(0, J_SCREEN_HEIGHT - 25 * layoutBy6() - 10 * layoutBy6(), J_SCREEN_WIDTH, 10 * layoutBy6());
    self.compnyLbl.frame = CGRectMake(0, self.phoneLbl.top - 9.5 * layoutBy6() - 10 * layoutBy6(), J_SCREEN_WIDTH, 10 * layoutBy6());
}

-(UIImageView *)logoView {
    if (!_logoView) {
        _logoView = [[UIImageView alloc] init];
        _logoView.image = [UIImage imageNamed:@"icon-logo-"];
    }
    return _logoView;
}

-(UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.text = @"他律";
        _nameLbl.textColor = RGBA(46, 187, 89, 1);
        _nameLbl.font = [UIFont fontWithName:K_BoldMT size:24 * layoutBy6()];
        _nameLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _nameLbl;
}

-(UILabel *)versionLbl {
    if (!_versionLbl) {
        _versionLbl = [[UILabel alloc] init];
        _versionLbl.text = @"1.10.0";
        _versionLbl.textColor = RGBA(51, 51, 51, 1);
        _versionLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _versionLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _versionLbl;
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"当前已是最新版本";
        _tipsLbl.textColor = RGBA(102, 102, 102, 1);
        _tipsLbl.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLbl;
}

-(UILabel *)compnyLbl {
    if (!_compnyLbl) {
        _compnyLbl = [[UILabel alloc] init];
        _compnyLbl.text = @"深圳市他律信息技术有限公司 版权所有";
        _compnyLbl.textColor = RGBA(153, 153, 153, 1);
        _compnyLbl.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _compnyLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _compnyLbl;
}

-(UILabel *)phoneLbl {
    if (!_phoneLbl) {
        _phoneLbl = [[UILabel alloc] init];
        _phoneLbl.text = @"客服热线：0775-6666666";
        _phoneLbl.textColor = RGBA(153, 153, 153, 1);
        _phoneLbl.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _phoneLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _phoneLbl;
}

@end
