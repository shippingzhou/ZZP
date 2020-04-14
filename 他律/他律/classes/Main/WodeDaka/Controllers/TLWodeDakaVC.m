//
//  TLWodeDakaVC.m
//  他律
//
//  Created by sineboy on 2019/12/20.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLWodeDakaVC.h"
#import "TLWodeDakaHeadView.h"
#import "TLWodeDakaCell.h"
#import "TLLvyouQuanModel.h"
#import "KNPhotoBrower.h"
#import "TLTipsAlertView.h"

@interface TLWodeDakaVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL     _ApplicationStatusIsHidden;
}

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@property (nonatomic, strong) TLWodeDakaHeadView *headView;

@property (nonatomic, strong) TLTipsAlertView *alertView;

@end

@implementation TLWodeDakaVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)setupSubViewUI {
    [self.view addSubview:self.headView];
    __weak typeof(self)weakSelf = self;
    self.headView.addBtnCallback = ^(id sender) {
        weakSelf.alertView.tags = @"1";
//        weakSelf.alertView.tags = @"2";
        weakSelf.alertView.hidden = NO;
    };
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.alertView];
    self.alertView.cancelBtnCallback = ^(id sender) {
        weakSelf.alertView.hidden = YES;
    };
    self.alertView.confirmBtnCallback = ^(id sender) {
        
    };
    [self makeSubViewContraint];
}

-(void)makeSubViewContraint {
    self.headView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 117 * layoutBy6());
    self.alertView.frame = self.view.bounds;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = NO;
}


#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLWodeDakaCell *cell = [TLWodeDakaCell cellWithTableView:tableView withIdentifer:@"wodedakaId"];
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 117 * layoutBy6(), J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_TabBarHeight - 117 * layoutBy6()) style:UITableViewStylePlain];
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

-(TLWodeDakaHeadView *)headView {
    if (!_headView) {
        _headView = [[TLWodeDakaHeadView alloc] init];
        _headView.backgroundColor = hexStringToColor(@"f5f7fb");
    }
    return _headView;
}

-(TLTipsAlertView *)alertView {
    if (!_alertView) {
        _alertView = [[TLTipsAlertView alloc] init];
        _alertView.hidden = YES;
    }
    return _alertView;
}


@end
