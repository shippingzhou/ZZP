//
//  TLSystemNotification.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSystemNotification.h"
#import "TLSystemModel.h"
#import "TLNoNotionficationCell.h"
#import "TLSystemNotificationCell.h"

@interface TLSystemNotification ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, copy) NSString *showStr;

@end

@implementation TLSystemNotification

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
        TLNoNotionficationCell *cell = [TLNoNotionficationCell cellWithTableView:tableView withIdentifer:@"noSystemId"];
        cell.title = @"暂无系统消息";
        return cell;
    }
    TLSystemNotificationCell *cell = [TLSystemNotificationCell cellWithTableView:tableView withIdentifer:@"mySystemId"];
    TLSystemModel *model = self.arr[indexPath.row];
    __weak typeof(self)weakSelf = self;
    cell.chakanCallback = ^(id sender) {
        model.isOpen = !model.isOpen;
        [weakSelf.tableView reloadData];
    };
    cell.model = model;
    return cell;
}



#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.showStr isEqualToString:@"show"]) {
        return J_SCREEN_HEIGHT - 120 * layoutBy6();
    }else {
        TLSystemModel *model = self.arr[indexPath.row];
        if ([model.type isEqualToString:@"点赞"]) {
            return model.cellHeight;
        }
        return model.systemCellHeight;
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
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"打卡",
                            @"content": @"",
                            @"systemContent": @"恭喜您粉丝数量突破1000人，获得“监察者”勋章！感谢您对“他律”做出的贡献。"
                            };
    NSDictionary *dict2 = @{
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"打卡",
                            @"content": @"",
                            @"systemContent": @"太厉害了！排行榜总榜第八名！恭喜您获得排名专有勋章。优秀是一种习惯，千万律友将以你为榜样。如果太长就显长就显长就显长就显"
                            };
    NSDictionary *dict3 = @{
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"评论",
                            @"content": @"",
                            @"systemContent": @"您的粉丝已成功突破10000人，恭喜成为“他律”大V，获得特殊勋章“V”。代千万律友感谢您的分享！内容全部展开了。内容全部展开了。内容全部展开了。内容全部展开了。内容全部展开了。内容全部展开了。阿萨德卡三等奖撒肯德基撒肯德基撒开大数据库了解到卡萨丁看撒金卡价"
                            };
    NSDictionary *dict4 = @{
                            @"date": @"2019年10月1日 9:30",
                            @"type": @"点赞",
                            @"systemContent": @"",
                            @"content": @"我：知止而后有定，定而后能静，静而后能思，思而后能虑，虑而后能得。吧啦吧啦吧啦吧啦吧啦啦吧啦啦吧啦吧啦啦吧啦吧啦吧啦吧啦最多吧啦三行就行了，多了就......."
                            };
    
    NSArray *arr1 = @[dict1, dict2, dict3, dict4];
    for (int i = 0; i < arr1.count; i++) {
        
        TLSystemModel *model = [TLSystemModel mj_objectWithKeyValues:arr1[i]];
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
