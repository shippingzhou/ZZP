//
//  TLHomepageVC.m
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLHomepageVC.h"
#import "TLHomepageHeadView.h"
#import "TLNoPlansCell.h"
#import "TLMyPlanModel.h"
#import "TLMyPlansCell.h"
#import "TLMyGroupCell.h"
#import "TLGroupModel.h"

#define scrollWidth (345 * layoutBy6())

@interface TLHomepageVC ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLHomepageHeadView *headView;

@property (nonatomic, assign) NSInteger currIndex;

@property (nonatomic, weak) NSTimer *timer; //定时器

@property (nonatomic, assign) NSInteger bannerCount;//banner图片数

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *planArr;

@property (nonatomic, strong) NSMutableArray *groupArr;

@property (nonatomic, copy) NSString *planShow;


@end

@implementation TLHomepageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self getBannarData];
    [self getMyPlanData];
    [self getMyGroupData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.headView];
    __weak typeof(self)weakSelf = self;
    self.headView.cycleScrollCallBack = ^(id sender) {
        [weakSelf didClickCycleScrollView:[sender integerValue]];//点击轮播图跳转
    };
    [self.view addSubview:self.tableView];
    
    self.timer= [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(autoScrollWithBanner) userInfo:nil repeats:YES];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.headView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 188.5 * layoutBy6());
}

/** 点击图片回调 */
-(void)didClickCycleScrollView:(NSInteger)index {
    
}

//自动轮播
-(void)autoScrollWithBanner {
    CGFloat contentOffx = (CGFloat)self.headView.bannerScrollView.contentOffset.x;
    NSInteger index = (NSInteger)contentOffx/scrollWidth + 0.5;
    self.currIndex = index;
    index += 1;

    if (index >= self.bannerCount) {
        index = 0;
    }
    [UIView animateWithDuration:0.4 animations:^{

        self.headView.bannerScrollView.contentOffset = CGPointMake(index * scrollWidth, 0);
    }];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {

    [self.timer invalidate];
    self.timer = nil;

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGFloat contentOffx = scrollView.contentOffset.x;
    CGFloat flo = (float)contentOffx/scrollWidth;
    self.currIndex = (NSInteger)(contentOffx/scrollWidth);
    NSLog(@"========%zd",self.currIndex);
    if (self.currIndex > 0 && self.currIndex < self.bannerCount - 1 && flo - self.currIndex > 0.5) {
        self.currIndex = self.currIndex + 1;
    }else if (self.currIndex == 0 && flo - self.currIndex > 0.5) {
        self.currIndex = self.currIndex + 1;
    }
    self.headView.bannerScrollView.contentOffset = CGPointMake(self.currIndex * scrollWidth, 0);

    self.timer= [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoScrollWithBanner) userInfo:nil repeats:YES];

}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        if ([self.planShow isEqualToString:@"show"]) {
            return 1;
        }else {
            return self.planArr.count;
        }
    }else {
        return self.groupArr.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    __weak typeof(self)weakSelf = self;
    if (indexPath.section == 0) {
        if ([self.planShow isEqualToString:@"show"]) {
            TLNoPlansCell *cell = [TLNoPlansCell cellWithTableView:tableView withIdentifer:@"noPlansID"];
            
            cell.addBtnCallBack = ^(id sender) {
                
            };
            return cell;
        }else {
            TLMyPlansCell *cell = [TLMyPlansCell cellWithTableView:tableView withIdentifer:@"myPlansID"];
            cell.model = self.planArr[indexPath.row];
            cell.fabuBtnCallBack = ^(id sender) {
                
            };
            return cell;
        }
    }else if (indexPath.section == 1) {
        TLMyGroupCell *cell = [TLMyGroupCell cellWithTableView:tableView withIdentifer:@"myGroupID"];
        cell.model = self.groupArr[indexPath.row];
        cell.remindBtnCallBack = ^(id sender) {
            
        };
        return cell;
    }else {
        return nil;
    }
    
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if ([self.planShow isEqualToString:@"show"]) {
            return 114.5 * layoutBy6();
        }else {
            return 74.5 * layoutBy6();
        }
    }else {
        TLGroupModel *model = self.groupArr[indexPath.row];
        if ([model.isLong isEqualToString:@"1"]) {
            return 99.5 * layoutBy6();
        }else {
            return 78.5 * layoutBy6();
        }
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 34.5 * layoutBy6());
    bgView.backgroundColor = hexStringToColor(@"f5f7fb");
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.frame = CGRectMake(15 * layoutBy6(), 10.5 * layoutBy6(), 200 * layoutBy6(), 13 * layoutBy6());
    if (section == 0) {
        titleLbl.text = @"我的计划";
    }else if (section == 1) {
        titleLbl.text = @"我的改变小组";
    }
    
    titleLbl.textColor = hexStringToColor(@"333333");
    titleLbl.font = [UIFont systemFontOfSize:15 * layoutBy6()];
    [bgView addSubview:titleLbl];
    return bgView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 34.5 * layoutBy6();
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

-(void)getBannarData {
    NSArray *arr = @[@"http://182.61.149.245/627905544778289152.jpg", @"http://182.61.149.245/627905104128905216.jpg", @"http://182.61.149.245/627921802949169152.jpg"];
    self.headView.bannerArr = arr.copy;
    self.bannerCount = arr.count;
    [self.headView addBannerToScrollView];
    
}

-(void)getMyPlanData {
    self.planArr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"title": @"改变易怒的坏习惯",
                            @"tips": @"尚未记录今日变现，已坚持1天，完成度5%"
                            };
    NSDictionary *dict2 = @{
                            @"title": @"培养包容的好习惯",
                            @"tips": @"今日记录1次，已坚持2天，完成度10%"
                            };
    NSArray *arr1 = @[dict1, dict2];
    for (int i = 0; i < arr1.count; i++) {
        TLMyPlanModel *model = [TLMyPlanModel mj_objectWithKeyValues:arr1[i]];
        [self.planArr addObject:model];
    }
    [self.tableView reloadData];
}

-(void)getMyGroupData {
    self.groupArr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"name": @"改变自己U1398（组长）",
                            @"title": @"培养包容的好习惯",
                            @"tips": @"预计13:00打卡，已坚持1天，完成度5%",
                            @"buttonTitle": @"提醒打卡",
                            @"isLong": @"1"
                            };
    NSDictionary *dict2 = @{
                            @"name": @"奋斗者U1388",
                            @"title": @"无执行中的计划",
                            @"tips": @"",
                            @"buttonTitle": @"已提醒",
                            @"isLong": @"0"
                            };
    NSDictionary *dict3 = @{
                            @"name": @"改变自己U1398",
                            @"title": @"培养包容的好习惯",
                            @"tips": @"尚未记录今日表现，已坚持1天，完成度5%",
                            @"buttonTitle": @"已提醒",
                            @"isLong": @"1"
                            };
    NSDictionary *dict4 = @{
                            @"name": @"改变自己U1398",
                            @"title": @"培养包容的好习惯",
                            @"tips": @"今日记录2次，已坚持2天，完成度10%",
                            @"buttonTitle": @"已为队友点赞",
                            @"isLong": @"1"
                            };
    NSArray *arr1 = @[dict1, dict2, dict3, dict4];
    for (int i = 0; i < arr1.count; i++) {
        TLGroupModel *model = [TLGroupModel mj_objectWithKeyValues:arr1[i]];
        [self.groupArr addObject:model];
    }
    [self.tableView reloadData];
}

-(TLHomepageHeadView *)headView {
    if (!_headView) {
        _headView = [[TLHomepageHeadView alloc] init];
        _headView.bannerScrollView.delegate = self;
        _headView.backgroundColor = hexStringToColor(@"f5f7fb");
    }
    return _headView;
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_TabBarHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = hexStringToColor(@"f5f7fb");
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableHeaderView = self.headView;
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
