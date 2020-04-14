//
//  TLRemindLvyouQuanVC.m
//  他律
//
//  Created by sineboy on 2019/12/22.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLRemindLvyouQuanVC.h"
#import "TLLvyouQuanRemindCell.h"
#import "TLHongbaoWeidakaiView.h"
#import "TLHongbaoYidakaiView.h"

@interface TLRemindLvyouQuanVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) TLHongbaoWeidakaiView *weidakaiView;

@property (nonatomic, strong) TLHongbaoYidakaiView *yidakaiView;

@end

@implementation TLRemindLvyouQuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self getRemindData];
    // Do any additional setup after loading the view.
}

-(void)setupSubViewUI {
    [self.view addSubview:self.tableView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.weidakaiView];
    __weak typeof(self)weakSelf = self;
    self.weidakaiView.openBtnCallback = ^(id sender) {
        weakSelf.weidakaiView.hidden = YES;
        weakSelf.yidakaiView.hidden = NO;
    };
    self.weidakaiView.closeBtnCallback = ^(id sender) {
        weakSelf.weidakaiView.hidden = YES;
    };
    [[UIApplication sharedApplication].keyWindow addSubview:self.yidakaiView];
    self.yidakaiView.openBtnCallback = ^(id sender) {
        
    };
    self.yidakaiView.closeBtnCallback = ^(id sender) {
        weakSelf.yidakaiView.hidden = YES;
    };
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.weidakaiView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
    self.yidakaiView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLLvyouQuanRemindCell *cell = [TLLvyouQuanRemindCell cellWithTableView:tableView withIdentifer:@"lvyouQuanRemindID"];
    __weak typeof(self)weakSelf = self;
    cell.model = self.arr[indexPath.row];
    cell.remindBtnCallBack = ^(id sender) {
        weakSelf.weidakaiView.hidden = NO;
    };
    return cell;
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 79 * layoutBy6();
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = hexStringToColor(@"f5f7fb");
    view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 40 * layoutBy6());
    UILabel *tittle = [[UILabel alloc] init];
    tittle.frame = CGRectMake(0, 25.5 * layoutBy6(), J_SCREEN_WIDTH, 11 * layoutBy6());
    tittle.text = @"感谢您的热心提醒，今日暂无超时未打卡";
    tittle.textColor = hexStringToColor(@"999999");
    tittle.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    tittle.textAlignment = NSTextAlignmentCenter;
    [view addSubview:tittle];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 40 * layoutBy6();
}

-(void)getRemindData {
    self.arr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"name": @"改变自己U1398",
                            @"title": @"培养包容的好习惯",
                            @"buttonTitle": @"提醒打卡"
                            };
    NSDictionary *dict2 = @{
                            @"name": @"改变自己U1398",
                            @"title": @"培养包容的好习惯",
                            @"buttonTitle": @"已提醒打卡"
                            };
    NSDictionary *dict3 = @{
                            @"name": @"改变自己U1398",
                            @"title": @"培养包容的好习惯",
                            @"buttonTitle": @"已提醒打卡"
                            };
    NSArray *arr1 = @[dict1, dict2, dict3];
    for (int i = 0; i < arr1.count; i++) {
        TLGroupModel *model = [TLGroupModel mj_objectWithKeyValues:arr1[i]];
        [self.arr addObject:model];
    }
    [self.tableView reloadData];
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_TabBarHeight) style:UITableViewStylePlain];
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

-(TLHongbaoWeidakaiView *)weidakaiView {
    if (!_weidakaiView) {
        _weidakaiView = [[TLHongbaoWeidakaiView alloc] init];
        _weidakaiView.hidden = YES;
    }
    return _weidakaiView;
}

-(TLHongbaoYidakaiView *)yidakaiView {
    if (!_yidakaiView) {
        _yidakaiView = [[TLHongbaoYidakaiView alloc] init];
        _yidakaiView.hidden = YES;
    }
    return _yidakaiView;
}

@end
