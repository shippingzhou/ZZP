//
//  TLMyPlansVC.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMyPlansVC.h"
#import "TLPersonalNoPlansCell.h"
#import "TLPersonalMyPlansCell.h"
#import "TLPlansModel.h"
#import "TLPlansContentVC.h"

@interface TLMyPlansVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, copy) NSString *showStr;

@end

@implementation TLMyPlansVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    [self creatLeftEnble];
    self.title = @"我的计划";
    [self creatRightWithString:@"新建计划" withHex:@"26c239" withFontStr:15 * layoutBy6()];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.showStr isEqualToString:@"show"]) {
        return 1;
    }
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.showStr isEqualToString:@"show"]) {
        TLPersonalNoPlansCell *cell = [TLPersonalNoPlansCell cellWithTableView:tableView withIdentifer:@"noPlansId"];
        return cell;
    }
    TLPersonalMyPlansCell *cell = [TLPersonalMyPlansCell cellWithTableView:tableView withIdentifer:@"myPlansId"];
    cell.model = self.arr[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.showStr isEqualToString:@"show"]) {
        return J_SCREEN_HEIGHT - J_StatusBarAndNavBarHeight;
    }else {
        return 105 * layoutBy6();
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TLPlansContentVC *vc = [[TLPlansContentVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)getData {
//    self.showStr = @"show";
//    [self.tableView reloadData];
    self.arr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"title": @"【培养新习惯】每天阅读10分钟",
                            @"rate": @"63",
                            @"allDay": @"30",
                            @"nowDay": @"21",
                            @"lastDay": @"9",
                            @"status": @"未完成"
                            };
    NSDictionary *dict2 = @{
                            @"title": @"【分享好习惯】每天健身5分钟",
                            @"rate": @"100",
                            @"allDay": @"30",
                            @"nowDay": @"30",
                            @"lastDay": @"0",
                            @"status": @"圆满完成"
                            };
    NSDictionary *dict3 = @{
                            @"title": @"【分享好习惯】每天健身5分钟",
                            @"rate": @"100",
                            @"allDay": @"33",
                            @"nowDay": @"30",
                            @"lastDay": @"0",
                            @"status": @"完成"
                            };
    NSArray *arr1 = @[dict1, dict2, dict3];
    for (int i = 0; i < arr1.count; i++) {
        
        TLPlansModel *model = [TLPlansModel mj_objectWithKeyValues:arr1[i]];
        [self.arr addObject:model];
    }
    [self.tableView reloadData];
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, J_StatusBarAndNavBarHeight, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_StatusBarAndNavBarHeight) style:UITableViewStylePlain];
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



@end
