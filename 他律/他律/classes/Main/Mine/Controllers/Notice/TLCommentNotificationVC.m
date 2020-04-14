//
//  TLCommentNotificationVC.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLCommentNotificationVC.h"
#import "TLNotificationModel.h"
#import "TLNoNotionficationCell.h"
#import "TLCommentNotificationCell.h"

@interface TLCommentNotificationVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, copy) NSString *showStr;

@end

@implementation TLCommentNotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getData];
    
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
        TLNoNotionficationCell *cell = [TLNoNotionficationCell cellWithTableView:tableView withIdentifer:@"noCommentId"];
        cell.title = @"暂无评论消息";
        return cell;
    }
    TLCommentNotificationCell *cell = [TLCommentNotificationCell cellWithTableView:tableView withIdentifer:@"myCommentId"];
    cell.model = self.arr[indexPath.row];
    return cell;
}



#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.showStr isEqualToString:@"show"]) {
        return J_SCREEN_HEIGHT - 120 * layoutBy6();
    }else {
        TLNotificationModel *model = self.arr[indexPath.row];
        return model.cellHeight;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


-(void)getData {
    //        self.showStr = @"show";
    //        [self.tableView reloadData];
    //
    //    return;
    self.arr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"authorName": @"改变自己U1213",
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"打卡",
                            @"title": @"【分享好习惯】阅读啊啊",
                            @"content": @"过去的行为决定了我们当下的处境，同样，当下的行动也会决定我们的未来。加油。",
                            @"comment": @"啊是肯德基撒看的撒宽带连接奥斯卡电视剧啊打开了撒娇打卡实际的撒肯德基奥斯卡卡三等奖阿克苏"
                            };
    NSDictionary *dict2 = @{
                            @"authorName": @"改变自己U1213",
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"评论",
                            @"title": @"",
                            @"content": @"过去的行为决定了撒旦教卡可视对讲奥斯卡的吉安市扣篮大赛京东卡世纪大厦科技大厦里奥斯卡的吉安市肯德基阿萨德拉斯角度看暗杀教室肯德基爱上肯德基撒拉丝机的卡萨丁家上课了加上肯德基阿萨德来看啊就SDK啊就SDK撒角度看按实际看",
                            @"comment": @"啊是肯德基撒看的撒宽带连接奥斯卡电视剧啊打开了撒娇打卡实际的撒肯德基奥斯卡卡三等奖阿克苏"
                            };
    NSDictionary *dict3 = @{
                            @"authorName": @"改变自己U1213",
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"话题",
                            @"title": @"【话题】阅读啊啊",
                            @"content": @"过去的行为决定了我们当下的处境，同样，当下的行动也会决定我们的未来。加油。",
                            @"comment": @"啊是肯德基撒看的撒宽带连接奥斯卡电视剧啊打开了撒娇打卡实际的撒肯德基奥斯卡卡三等奖阿克苏"
                            };
    
    NSArray *arr1 = @[dict1, dict2, dict3];
    for (int i = 0; i < arr1.count; i++) {
        
        TLNotificationModel *model = [TLNotificationModel mj_objectWithKeyValues:arr1[i]];
        [self.arr addObject:model];
    }
    [self.tableView reloadData];
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - 120 * layoutBy6()) style:UITableViewStylePlain];
        _tableView.backgroundColor = hexStringToColor(@"ffffff");
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
