//
//  TLSettingVC.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSettingVC.h"
#import "TLSettingCell.h"
#import "TLSettingModel.h"
#import "TLSettingAboutCell.h"
#import "TLAboutUsVC.h"
#import "TLOpinionVC.h"

@interface TLSettingVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr1;

@property (nonatomic, strong) NSMutableArray *arr2;

@property (nonatomic, strong) UIButton *logoutBtn;

@end

@implementation TLSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self creatLeftEnble];
    self.title = @"设置";
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutBtn];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.logoutBtn.frame = CGRectMake(0, J_SCREEN_HEIGHT - 50 * layoutBy6(), J_SCREEN_WIDTH, 50 * layoutBy6());
}

-(void)didClickLogoutBtn {
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.arr1.count;
    }else {
        return self.arr2.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TLSettingCell *cell = [TLSettingCell cellWithTableView:tableView withIdentifer:@"settingID"];
        cell.model = self.arr1[indexPath.row];
        __weak typeof(self)weakSelf = self;
        cell.switchBtnCallback = ^(UISwitch *sender) {
            sender.on = !sender.on;
        };
        return cell;
    }else {
        TLSettingAboutCell *cell = [TLSettingAboutCell cellWithTableView:tableView withIdentifer:@"settingAboutID"];
        cell.model = self.arr2[indexPath.row];
        return cell;
    }
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55 * layoutBy6();
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = hexStringToColor(@"f5f7fb");
    view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 10 * layoutBy6());
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 * layoutBy6();
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            TLAboutUsVC *vc = [[TLAboutUsVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            TLOpinionVC *vc = [[TLOpinionVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}


-(void)getData {
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"subTitle": @"关闭后，当日忘记打卡时，将不再通知你",
                            @"title": @"接收他律官方打卡提醒",
                            @"isOn": @"off"
                            };
    NSDictionary *dict2 = @{
                            @"subTitle": @"关闭后，律友新关注你时，将不再通知你",
                            @"title": @"接收新关注提醒",
                            @"isOn": @"on"
                            };
    NSDictionary *dict3 = @{
                            @"subTitle": @"关闭后，你邀请的好友注册后，将不再通知你",
                            @"title": @"邀请注册提醒",
                            @"isOn": @"on"
                            };
    NSDictionary *dict4 = @{
                            @"subTitle": @"关闭后，律友点赞你时，将不再通知你",
                            @"title": @"接收律友的点赞提醒",
                            @"isOn": @"on"
                            };
    NSDictionary *dict5 = @{
                            @"subTitle": @"关闭后，律友评论你时，将不再通知你",
                            @"title": @"接收律友的评论提醒",
                            @"isOn": @"on"
                            };
    NSDictionary *dict6 = @{
                            @"subTitle": @"关闭后，律友提醒你建立计划时，将不再通知你",
                            @"title": @"接收律友的提醒建立计划通知",
                            @"isOn": @"on"
                            };
    NSDictionary *dict7 = @{
                            @"subTitle": @"关闭后，律友提醒你打卡时，将不再通知你",
                            @"title": @"接收律友的提醒打卡通知",
                            @"isOn": @"on"
                            };
    NSDictionary *dict8 = @{
                            @"subTitle": @"",
                            @"title": @"关于他律",
                            @"isOn": @"on"
                            };
    NSDictionary *dict9 = @{
                            @"subTitle": @"你的意见也许能帮助到成千上万的律友",
                            @"title": @"意见反馈",
                            @"isOn": @"on"
                            };
    NSArray *arr1 = @[dict1, dict2, dict3, dict4, dict5, dict6, dict7];
    NSArray *arr2 = @[dict8, dict9];
    for (int i = 0; i < arr1.count; i++) {
        TLSettingModel *model = [TLSettingModel mj_objectWithKeyValues:arr1[i]];
        [self.arr1 addObject:model];
    }
    for (int i = 0; i < arr2.count; i++) {
        TLSettingModel *model = [TLSettingModel mj_objectWithKeyValues:arr2[i]];
        [self.arr2 addObject:model];
    }
    [self.tableView reloadData];
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, J_StatusBarAndNavBarHeight, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_StatusBarAndNavBarHeight - 50 * layoutBy6()) style:UITableViewStylePlain];
        _tableView.backgroundColor = hexStringToColor(@"f5f7fb");
        _tableView.dataSource = self;
        _tableView.delegate = self;
        //_tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        //        __weak typeof(self) weakSelf = self;
        //        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //
        //            [weakSelf.tableView reloadData];
        //            [weakSelf.tableView.mj_header endRefreshing];
        //        }];
        //        //上拉刷新
        //        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        //
        //            [weakSelf.tableView reloadData];
        //            [weakSelf.tableView.mj_footer endRefreshing];
        //        }];
    }
    return _tableView;
}

-(UIButton *)logoutBtn {
    if (!_logoutBtn) {
        _logoutBtn = [[UIButton alloc] init];
        _logoutBtn.backgroundColor = hexStringToColor(@"ffffff");
        [_logoutBtn setTitle:@"退出" forState:UIControlStateNormal];
        [_logoutBtn setTitleColor:hexStringToColor(@"4fcd60") forState:UIControlStateNormal];
        _logoutBtn.titleLabel.font = [UIFont systemFontOfSize:18 * layoutBy6()];
        [_logoutBtn addTarget:self action:@selector(didClickLogoutBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutBtn;
}


@end
