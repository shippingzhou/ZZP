//
//  TLLvYouQuanVC.m
//  他律
//
//  Created by sineboy on 2019/12/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLvYouQuanVC.h"
#import "TLNewestLvyouQuanVC.h"
#import "TLGroupLvyouQuanVC.h"
#import "TLGuanzhuLvyouQuanVC.h"
#import "TLRemindLvyouQuanVC.h"
#import <objc/runtime.h>

@interface TLLvYouQuanVC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *headView;

@property (nonatomic, strong) UITextField *searchField;

@property (nonatomic, strong) UIButton *faqiBtn;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIView *underLine;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TLNewestLvyouQuanVC *newestVC;

@property (nonatomic, strong) TLGroupLvyouQuanVC *groupVC;

@property (nonatomic, strong) TLGuanzhuLvyouQuanVC *guanzhuVC;

@property (nonatomic, strong) TLRemindLvyouQuanVC *remindVC;

@end

@implementation TLLvYouQuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.searchField];
    [self.view addSubview:self.faqiBtn];
    [self.view addSubview:self.underLine];
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.newestVC];
    [self addChildViewController:self.groupVC];
    [self addChildViewController:self.guanzhuVC];
    [self addChildViewController:self.remindVC];
    [self.scrollView addSubview:self.newestVC.view];
    [self.scrollView addSubview:self.groupVC.view];
    [self.scrollView addSubview:self.guanzhuVC.view];
    [self.scrollView addSubview:self.remindVC.view];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.headView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 107 * layoutBy6());
    self.searchField.frame = CGRectMake(14.5 * layoutBy6(), 25.5 * layoutBy6(), J_SCREEN_WIDTH - 94.5 * layoutBy6(), 30 * layoutBy6());
    self.faqiBtn.frame = CGRectMake(self.searchField.right + 3.5 * layoutBy6(), 34 * layoutBy6(), 70 * layoutBy6(), 14 * layoutBy6());
    NSInteger count = self.titleArr.count;
    CGFloat btnWidth = J_SCREEN_WIDTH/count;
    for (int i = 0; i < 4; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(i * btnWidth, 63 * layoutBy6(), btnWidth, 44 * layoutBy6());
        
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        [btn setTitleColor:hexStringToColor(@"333333") forState:UIControlStateNormal];
        [btn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateSelected];
        if (i == 0) {
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
            self.underLine.frame = CGRectMake(btnWidth/2 - 25/2 * layoutBy6(), 96.5 * layoutBy6(), 25 * layoutBy6(), 1 * layoutBy6());
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
    self.scrollView.frame = CGRectMake(0, 107 * layoutBy6(), J_SCREEN_WIDTH, J_SCREEN_HEIGHT - 107 * layoutBy6() - J_TabBarHeight);
    self.newestVC.view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.groupVC.view.frame = CGRectMake(J_SCREEN_WIDTH, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.guanzhuVC.view.frame = CGRectMake(J_SCREEN_WIDTH * 2, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.remindVC.view.frame = CGRectMake(J_SCREEN_WIDTH * 3, 0, J_SCREEN_WIDTH, self.scrollView.height);
}

-(void)didClickFaqiBtn:(UIButton *)btn {
    
}

-(void)didClickTitleBtn:(UIButton *)btn {
    if (btn.tag == 0) {
        [self.newestVC getData];
    }
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    self.scrollView.contentOffset = CGPointMake(btn.tag * J_SCREEN_WIDTH, 0);
    [UIView animateWithDuration:0.4 animations:^{
        if (btn.tag == 3) {
            self.underLine.width = 56 * layoutBy6();
            self.underLine.left = btn.left + btn.width/2 - 56/2 * layoutBy6();
        }else {
            self.underLine.width = 25 * layoutBy6();
            self.underLine.left = btn.left + btn.width/2 - 25/2 * layoutBy6();
        }
        
        
    }];
}

-(UIView *)headView {
    if (!_headView) {
        _headView = [[UIView alloc] init];
        _headView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _headView;
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

-(UIButton *)faqiBtn {
    if (!_faqiBtn) {
        _faqiBtn = [[UIButton alloc] init];
        [_faqiBtn setTitle:@"发起话题" forState:UIControlStateNormal];
        [_faqiBtn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateNormal];
        _faqiBtn.titleLabel.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        [_faqiBtn addTarget:self action:@selector(didClickFaqiBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _faqiBtn;
}

-(NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"最新", @"小组", @"关注", @"热心提醒"];
    }
    return _titleArr;
}

-(UIView *)underLine {
    if (!_underLine) {
        _underLine = [[UIView alloc] init];
        _underLine.backgroundColor = hexStringToColor(@"26c239");
    }
    return _underLine;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.contentSize = CGSizeMake(J_SCREEN_WIDTH * 4, 0);
    }
    return _scrollView;
}

-(TLNewestLvyouQuanVC *)newestVC {
    if (!_newestVC) {
        _newestVC = [[TLNewestLvyouQuanVC alloc] init];
    }
    return _newestVC;
}

-(TLGroupLvyouQuanVC *)groupVC {
    if (!_groupVC) {
        _groupVC = [[TLGroupLvyouQuanVC alloc] init];
    }
    return _groupVC;
}

-(TLGuanzhuLvyouQuanVC *)guanzhuVC {
    if (!_guanzhuVC) {
        _guanzhuVC = [[TLGuanzhuLvyouQuanVC alloc] init];
    }
    return _guanzhuVC;
}

-(TLRemindLvyouQuanVC *)remindVC {
    if (!_remindVC) {
        _remindVC = [[TLRemindLvyouQuanVC alloc] init];
    }
    return _remindVC;
}

@end
