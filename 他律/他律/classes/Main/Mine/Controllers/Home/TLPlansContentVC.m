//
//  TLPlansContentVC.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLPlansContentVC.h"
#import "TLPlansContentHeadView.h"
#import "TLPlansModel.h"
#import "TLWodeDakaCell.h"
#import "TLLvyouQuanModel.h"
#import "KNPhotoBrower.h"

@interface TLPlansContentVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL     _ApplicationStatusIsHidden;
}

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) TLPlansContentHeadView *headView;

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation TLPlansContentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getHeadViewData];
    [self getData];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self creatLeftEnble];
    self.title = @"计划详情";
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.tableView];
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.headView.frame = CGRectMake(0, J_StatusBarAndNavBarHeight, J_SCREEN_WIDTH, 170 * layoutBy6());
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLWodeDakaCell *cell = [TLWodeDakaCell cellWithTableView:tableView withIdentifer:@"jihuaxiangqingId"];
    __weak typeof(self)weakSelf = self;
    cell.model = self.arr[indexPath.row];
    cell.personalCallBack = ^(id sender) {
        
    };
    cell.titleCallBack = ^(id sender) {
        
    };
    cell.contentCallBack = ^(id sender) {
        
    };
    cell.bottomBtnCallBack = ^(id sender) {
        
    };
    cell.picBtnCallBack = ^(id sender1, NSArray *arr) {
        [weakSelf openPreviewOfImgs:arr.copy withIndex:[sender1 integerValue]];
    };
    cell.shenpingCallBack = ^(id sender) {
        
    };
    return cell;
}


-(void)openPreviewOfImgs:(NSArray *)imgs withIndex:(NSInteger)index{
    KNPhotoBrower *photoBrower = [[KNPhotoBrower alloc] init];
    photoBrower.itemsArr = [imgs copy];
    photoBrower.currentIndex = index;
    
    // 如果设置了 photoBrower中的 actionSheetArr 属性. 那么 isNeedRightTopBtn 就应该是默认 YES, 如果设置成NO, 这个actionSheetArr 属性就没有意义了
    //    photoBrower.actionSheetArr = [self.actionSheetArray mutableCopy];
    
    [photoBrower setIsNeedRightTopBtn:NO]; // 是否需要 右上角 操作功能按钮
    [photoBrower setIsNeedPictureLongPress:YES]; // 是否 需要 长按图片 弹出框功能 .默认:需要
    // 设置代理方法 --->可不写
    [photoBrower setDelegate:self];
    [photoBrower present];
    // 这里是 设置 状态栏的 隐藏 ---> 可不写
    _ApplicationStatusIsHidden = YES;
    [self setNeedsStatusBarAppearanceUpdate];
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLLvyouQuanModel *model = self.arr[indexPath.row];
    return model.cellHeight;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 40 * layoutBy6());
    view.backgroundColor = hexStringToColor(@"f5f7fb");
    UIView *bgView = [[UIView alloc] init];
    bgView.frame = CGRectMake(0, 10 * layoutBy6(), J_SCREEN_WIDTH, 30 * layoutBy6());
    bgView.backgroundColor = hexStringToColor(@"ffffff");
    [view addSubview:bgView];
    
    UILabel *titleLbl = [[UILabel alloc] init];
    titleLbl.frame = CGRectMake(14.5 * layoutBy6(), bgView.top + 9 * layoutBy6(), 100 * layoutBy6(), 13 * layoutBy6());
    titleLbl.text = @"打卡记录";
    titleLbl.textColor = hexStringToColor(@"999999");
    titleLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
    [view addSubview:titleLbl];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(0, bgView.bottom - 0.5, J_SCREEN_WIDTH, 0.5);
    line.backgroundColor = hexStringToColor(@"e9e9e9");
    [view addSubview:line];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40 * layoutBy6();
}

-(void)getData {
    self.arr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                            @"authorImg": @"icon-logo-",
                            @"authorName": @"奋斗者",
                            @"date": @"2019年10月21日 15:20",
                            @"days": @"",
                            @"title": @"【培养新习惯】停止抱怨",
                            @"content": @"过去的行为决定了我们当下的处境，同样，当下的行动也会决定我们的未来。加油。",
                            @"imgs": @"http://182.61.149.245/627905544778289152.jpg,http://182.61.149.245/627905104128905216.jpg,http://182.61.149.245/627921802949169152.jpg",
                            @"isRead": @"1",
                            @"isComment": @"0",
                            @"isCollect": @"0",
                            @"isForward": @"1",
                            @"isGuanfang": @"1",
                            @"readCount": @"123万",
                            @"commentCount": @"123万",
                            @"collectCount": @"123万",
                            @"forwardCount": @"123万",
                            @"shenpingAuthor": @"过去的门",
                            @"shenpingContent": @"展示获得赞更多的回复，如果获赞数一样，展示评论时间靠前的",
                            @"isShenping": @"1"
                            };
    
    NSArray *arr1 = @[dict1];
    for (int i = 0; i < arr1.count; i++) {
        TLLvyouQuanModel *model = [TLLvyouQuanModel mj_objectWithKeyValues:arr1[i]];
        [self.arr addObject:model];
    }
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, J_StatusBarAndNavBarHeight, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_StatusBarAndNavBarHeight) style:UITableViewStylePlain];
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

-(void)getHeadViewData {
    TLPlansModel *model = [[TLPlansModel alloc] init];
    model.title = @"每天阅读五分钟";
    model.lastTime = @"18:00";
    model.beixuan = @"卡三等奖爱丽舍空间大说恐龙静安寺";
    model.nowDay = @"21";
    model.lastDay = @"9";
    model.rate = @"63";
    model.status = @"未完成";
    self.headView.model = model;
    if ([model.status isEqualToString:@"未完成"]) {
        self.headView.height = 170 * layoutBy6();
    }else {
        self.headView.height = 130 * layoutBy6();
    }
}



-(TLPlansContentHeadView *)headView {
    if (!_headView) {
        _headView = [[TLPlansContentHeadView alloc] init];
    }
    return _headView;
}

@end
