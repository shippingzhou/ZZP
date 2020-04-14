//
//  TLNotificationCenterVC.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNotificationCenterVC.h"
#import "TLLikeNotificationVC.h"
#import "TLCommentNotificationVC.h"
#import "TLRemindNotificationVC.h"
#import "TLSystemNotification.h"

@interface TLNotificationCenterVC ()

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) TLLikeNotificationVC *likeNoticationVC;

@property (nonatomic, strong) TLCommentNotificationVC *commentNoticationVC;

@property (nonatomic, strong) TLRemindNotificationVC *remindNoticationVC;

@property (nonatomic, strong) TLSystemNotification *systemNoticationVC;

@property (nonatomic, strong) UIButton *likeRed;

@property (nonatomic, strong) UIButton *commentRed;

@property (nonatomic, strong) UIButton *remindRed;

@property (nonatomic, strong) UIButton *systemRed;

@end

@implementation TLNotificationCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"ffffff");
    [self creatLeftEnble];
    self.title = @"消息中心";
    [self getData];
    [self creatRightWithString:@"全部设为已读" withHex:@"26c239" withFontStr:12 * layoutBy6()];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)rightItem {
    
}

-(void)setupSubViewUI {
    for (int i = 0; i < self.titleArr.count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(34.75 * layoutBy6() + i * (76 - 0.5) * layoutBy6(), 70 * layoutBy6(), 76 * layoutBy6(), 30.5 * layoutBy6());
        btn.layer.borderColor = hexStringToColor(@"e9e9e9").CGColor;
        btn.layer.borderWidth = 0.5 * layoutBy6();
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:hexStringToColor(@"333333") forState:UIControlStateNormal];
        [btn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateSelected];
        btn.backgroundColor = hexStringToColor(@"ffffff");
        btn.titleLabel.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        if (i == 0) {
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
            self.selectedBtn.backgroundColor = hexStringToColor(@"26c239");
        }
        btn.tag = i;
        [btn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
        UIButton *redBtn = [[UIButton alloc] init];
        redBtn.layer.cornerRadius = 6 * layoutBy6();
        redBtn.layer.masksToBounds = YES;
        redBtn.backgroundColor = hexStringToColor(@"FF3300");
        [redBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        redBtn.titleLabel.font = [UIFont systemFontOfSize:9 * layoutBy6()];
        if (i == 0) {
            self.likeRed = redBtn;
            redBtn.frame = CGRectMake(btn.right - 15 * layoutBy6() - 12 * layoutBy6(), btn.top - 3 * layoutBy6(), 12 * layoutBy6(), 12 * layoutBy6());
        }else if (i == 1) {
            self.commentRed = redBtn;
            redBtn.frame = CGRectMake(btn.right - 15 * layoutBy6() - 12 * layoutBy6(), btn.top - 3 * layoutBy6(), 12 * layoutBy6(), 12 * layoutBy6());
        }else if (i == 2) {
            self.remindRed = redBtn;
            redBtn.frame = CGRectMake(btn.right - 15 * layoutBy6() - 12 * layoutBy6(), btn.top - 3 * layoutBy6(), 12 * layoutBy6(), 12 * layoutBy6());
        }else if (i == 3) {
            self.systemRed = redBtn;
            redBtn.frame = CGRectMake(btn.right - 15 * layoutBy6() - 12 * layoutBy6(), btn.top - 3 * layoutBy6(), 12 * layoutBy6(), 12 * layoutBy6());
        }
        [self.view addSubview:redBtn];
    }
    [self.view addSubview:self.scrollView];
    [self addChildViewController:self.likeNoticationVC];
    [self.scrollView addSubview:self.likeNoticationVC.view];
    [self addChildViewController:self.commentNoticationVC];
    [self.scrollView addSubview:self.commentNoticationVC.view];
    [self addChildViewController:self.remindNoticationVC];
    [self.scrollView addSubview:self.remindNoticationVC.view];
    [self addChildViewController:self.systemNoticationVC];
    [self.scrollView addSubview:self.systemNoticationVC.view];
    [self makeSubViewContraint];

}

-(void)makeSubViewContraint {
    self.scrollView.frame = CGRectMake(0, 120 * layoutBy6(), J_SCREEN_WIDTH, J_SCREEN_HEIGHT - 120 * layoutBy6());
    self.likeNoticationVC.view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.commentNoticationVC.view.frame = CGRectMake(J_SCREEN_WIDTH, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.remindNoticationVC.view.frame = CGRectMake(J_SCREEN_WIDTH * 2, 0, J_SCREEN_WIDTH, self.scrollView.height);
    self.systemNoticationVC.view.frame = CGRectMake(J_SCREEN_WIDTH * 3, 0, J_SCREEN_WIDTH, self.scrollView.height);
}

-(void)didClickTitleBtn:(UIButton *)btn {
    self.selectedBtn.backgroundColor = hexStringToColor(@"ffffff");
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.backgroundColor = hexStringToColor(@"26c239");
    self.selectedBtn.selected = YES;
    
    self.scrollView.contentOffset = CGPointMake(btn.tag * J_SCREEN_WIDTH, 0);
}

-(void)getData {
    [self.likeRed setTitle:@"1" forState:UIControlStateNormal];
    [self.commentRed setTitle:@"12" forState:UIControlStateNormal];
    [self.remindRed setTitle:@"123" forState:UIControlStateNormal];
    [self.systemRed setTitle:@"1234" forState:UIControlStateNormal];
    CGFloat likeWidth = [[Untils defaultUntils] widthForString:self.likeRed.titleLabel.text fontSize:9 * layoutBy6() andWidth:40 * layoutBy6() andHeight:12 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    if (likeWidth < 12 * layoutBy6()) {
        self.likeRed.width = 12 * layoutBy6();
    }else {
        self.likeRed.width = likeWidth;
    }
    
    CGFloat commentWidth = [[Untils defaultUntils] widthForString:self.commentRed.titleLabel.text fontSize:9 * layoutBy6() andWidth:40 * layoutBy6() andHeight:12 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    if (commentWidth < 12 * layoutBy6()) {
        self.commentRed.width = 12 * layoutBy6();
    }else {
        self.commentRed.width = commentWidth;
    }
    
    CGFloat remindWidth = [[Untils defaultUntils] widthForString:self.remindRed.titleLabel.text fontSize:9 * layoutBy6() andWidth:40 * layoutBy6() andHeight:12 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    if (remindWidth < 12 * layoutBy6()) {
        self.remindRed.width = 12 * layoutBy6();
    }else {
        self.remindRed.width = remindWidth;
    }
    
    CGFloat systemWidth = [[Untils defaultUntils] widthForString:self.systemRed.titleLabel.text fontSize:9 * layoutBy6() andWidth:40 * layoutBy6() andHeight:12 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    if (systemWidth < 12 * layoutBy6()) {
        self.systemRed.width = 12 * layoutBy6();
    }else {
        self.systemRed.width = systemWidth;
    }
}

-(NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"点赞", @"评论", @"关注&提醒", @"系统"];
    }
    return _titleArr;
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

-(TLLikeNotificationVC *)likeNoticationVC {
    if (!_likeNoticationVC) {
        _likeNoticationVC = [[TLLikeNotificationVC alloc] init];
    }
    return _likeNoticationVC;
}

-(TLCommentNotificationVC *) commentNoticationVC{
    if (!_commentNoticationVC) {
        _commentNoticationVC = [[TLCommentNotificationVC alloc] init];
    }
    return _commentNoticationVC;
}

-(TLRemindNotificationVC *)remindNoticationVC {
    if (!_remindNoticationVC) {
        _remindNoticationVC = [[TLRemindNotificationVC alloc] init];
    }
    return _remindNoticationVC;
}

-(TLSystemNotification *)systemNoticationVC {
    if (!_systemNoticationVC) {
        _systemNoticationVC = [[TLSystemNotification alloc] init];
    }
    return _systemNoticationVC;
}


@end
