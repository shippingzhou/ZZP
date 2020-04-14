//
//  TLPersonalCenterVC.m
//  他律
//
//  Created by sineboy on 2020/2/10.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLPersonalCenterVC.h"
#import "TLPersonalCenterHeadView.h"

@interface TLPersonalCenterVC ()

@property (nonatomic, strong) TLPersonalCenterHeadView *headView;

@end

@implementation TLPersonalCenterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.headView];
    __weak typeof(self)weakSelf = self;
    self.headView.leftBtnCallBack = ^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    };
    self.headView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 236 * layoutBy6());
}

-(TLPersonalCenterHeadView *)headView {
    if (!_headView) {
        _headView = [[TLPersonalCenterHeadView alloc] init];
    }
    return _headView;
}

@end
