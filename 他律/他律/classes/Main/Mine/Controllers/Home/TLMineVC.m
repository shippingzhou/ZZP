//
//  TLMineVC.m
//  他律
//
//  Created by sineboy on 2019/12/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMineVC.h"
#import "TLMineHeadView.h"
#import "TLMineModel.h"
#import "TLMineCell.h"
#import "TLPersonalEditVC.h"
#import "TLMyPlansVC.h"
#import "TLSettingVC.h"
#import "TLNotificationCenterVC.h"

@interface TLMineVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLMineHeadView *headView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr1;

@property (nonatomic, strong) NSMutableArray *arr2;

@property (nonatomic, strong) NSMutableArray *arr3;

@end

@implementation TLMineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self getHeadViewData];
    [self getData];
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
    self.headView.personalEditCallback = ^(id sender) {
        TLPersonalEditVC *vc = [[TLPersonalEditVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.headView.settingEditCallback = ^(id sender) {
        TLSettingVC *vc = [[TLSettingVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.headView.emailEditCallback = ^(id sender) {
        TLNotificationCenterVC *vc = [[TLNotificationCenterVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    self.headView.likeEditCallback = ^(id sender) {
        
    };
    self.headView.commentEditCallback = ^(id sender) {
        
    };
    self.headView.dayEditCallback = ^(id sender) {
        
    };
    [self.view addSubview:self.tableView];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.headView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 182 * layoutBy6());
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 || section == 1) {
        return 2;
    }else {
        return 3;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLMineCell *cell = [TLMineCell cellWithTableView:tableView withIdentifer:@"mine"];
    if (indexPath.section == 0) {
        cell.model = self.arr1[indexPath.row];
    }else if (indexPath.section == 1) {
        cell.model = self.arr2[indexPath.row];
    }else {
        cell.model = self.arr3[indexPath.row];
    }
    return cell;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50 * layoutBy6();
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 10 * layoutBy6());
    view.backgroundColor = hexStringToColor(@"f5f7fb");
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10 * layoutBy6();
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1) {
            TLMyPlansVC *vc = [[TLMyPlansVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1) {
            
        }
    }else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            
        }else if (indexPath.row == 1) {
            
        }else if (indexPath.row == 2) {
            
        }
    }
}

-(void)getHeadViewData {
    //初始化
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    NSString *str1 = [NSString stringWithFormat:@"%@天",@"30"];
    NSString *str2 = [NSString stringWithFormat:@"(排名%@)",@"9999"];
    //文字
    NSMutableAttributedString *textString1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange textRange1 = NSMakeRange(0, str1.length);
    //行间距
    NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
    [style1 setAlignment:NSTextAlignmentCenter];
    style1.lineBreakMode = NSLineBreakByTruncatingTail;
    style1.lineSpacing = 5;
    [textString1 addAttribute:NSParagraphStyleAttributeName value:style1 range:textRange1];
    //文字颜色
    [textString1 addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"333333") range:textRange1];
    //字体
    [textString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 * layoutBy6()] range:textRange1];
    [attributedString appendAttributedString:textString1];
    
    //文字
    NSMutableAttributedString *textString2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange textRange2 = NSMakeRange(0, str2.length);
    //行间距
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    [style2 setAlignment:NSTextAlignmentCenter];
    style2.lineBreakMode = NSLineBreakByTruncatingTail;
    style2.lineSpacing = 5;
    [textString2 addAttribute:NSParagraphStyleAttributeName value:style2 range:textRange2];
    //文字颜色
    [textString2 addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"666666") range:textRange2];
    //字体
    [textString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10 * layoutBy6()] range:textRange2];
    
    
    [attributedString appendAttributedString:textString2];
    self.headView.dayCount.attributedText = attributedString;
}

-(void)getData {
    self.arr1 = [NSMutableArray array];
    self.arr2 = [NSMutableArray array];
    self.arr3 = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"icon": @"icon-gr-gz",
                            @"title": @"关注",
                            @"num1": @"100",
                            @"num2": @"13",
                            @"isShow": @"1"
                            };
    
    NSDictionary *dict2 = @{
                            @"icon": @"icon-gr-jh",
                            @"title": @"我的计划",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSDictionary *dict3 = @{
                            @"icon": @"icon-gr-zj",
                            @"title": @"我的足迹",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSDictionary *dict4 = @{
                            @"icon": @"icon-gr-pc",
                            @"title": @"我的测评",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSDictionary *dict5 = @{
                            @"icon": @"icon-gr-xz",
                            @"title": @"“他律”勋章",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSDictionary *dict6 = @{
                            @"icon": @"icon-gr-phb",
                            @"title": @"排行榜·优秀是一种习惯",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSDictionary *dict7 = @{
                            @"icon": @"icon-gr-jfsc",
                            @"title": @"积分商城",
                            @"num1": @"",
                            @"num2": @"",
                            @"isShow": @"0"
                            };
    NSArray *arr1 = @[dict1, dict2];
    NSArray *arr2 = @[dict3, dict4];
    NSArray *arr3 = @[dict5, dict6, dict7];
    for (int i = 0; i < arr1.count; i++) {
        TLMineModel *model = [TLMineModel mj_objectWithKeyValues:arr1[i]];
        [self.arr1 addObject:model];
    }
    for (int i = 0; i < arr2.count; i++) {
        TLMineModel *model = [TLMineModel mj_objectWithKeyValues:arr2[i]];
        [self.arr2 addObject:model];
    }
    for (int i = 0; i < arr3.count; i++) {
        TLMineModel *model = [TLMineModel mj_objectWithKeyValues:arr3[i]];
        [self.arr3 addObject:model];
    }
}

-(TLMineHeadView *)headView {
    if (!_headView) {
        _headView = [[TLMineHeadView alloc] init];
    }
    return _headView;
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 182 * layoutBy6(), J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_TabBarHeight - 182 * layoutBy6()) style:UITableViewStylePlain];
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
