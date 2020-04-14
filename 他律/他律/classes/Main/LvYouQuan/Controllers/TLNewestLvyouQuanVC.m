//
//  TLNewestLvyouQuanVC.m
//  他律
//
//  Created by sineboy on 2019/12/22.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNewestLvyouQuanVC.h"
#import "TLNewestLvyouQuanCell.h"
#import "TLLvyouQuanModel.h"
#import "KNPhotoBrower.h"
#import "TLPersonalCenterVC.h"

@interface TLNewestLvyouQuanVC ()<UITableViewDataSource,UITableViewDelegate>{
    BOOL     _ApplicationStatusIsHidden;
}

@property (nonatomic, strong) TLBaseTableView *tableView;

@property (nonatomic, strong) NSMutableArray *arr;

@end

@implementation TLNewestLvyouQuanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"f5f7fb");
    [self getData];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)setupSubViewUI {
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TLNewestLvyouQuanCell *cell = [TLNewestLvyouQuanCell cellWithTableView:tableView withIdentifer:@"newestId"];
    __weak typeof(self)weakSelf = self;
    cell.model = self.arr[indexPath.row];
    cell.personalCallBack = ^(id sender) {
        TLPersonalCenterVC *vc = [[TLPersonalCenterVC alloc] init];
        [weakSelf.navigationController pushViewController:vc animated:YES];
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

-(void)getData {
    self.arr = [NSMutableArray array];
    NSDictionary *dict1 = @{
                           @"authorImg": @"icon-logo-",
                           @"authorName": @"他律官方号",
                           @"date": @"2019年10月21日 15:20",
                           @"days": @"",
                           @"title": @"【话题】每个想放弃的瞬间，都是我们改变自己、超越自己的机会。",
                           @"content": @"阶段一：反抗期，计划开始后的第一周马上就想放弃。\n阶段二：不稳定期，计划开始后的第二、第三周，计划被各种各样的人和事情所干扰。\n阶段三：倦怠期，计划开始后的第四周，逐渐对计划",
                           @"imgs": @"",
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
    NSDictionary *dict2 = @{
                            @"authorImg": @"icon-logo-",
                            @"authorName": @"奋斗者",
                            @"date": @"2019年10月21日 15:20",
                            @"days": @"30",
                            @"title": @"【分享好习惯】停止抱怨",
                            @"content": @"过去的行为决定了我们当下的处境，同样，当下的行动也会决定我们的未来。加油。",
                            @"imgs": @"http://182.61.149.245/627905544778289152.jpg,http://182.61.149.245/627905104128905216.jpg,http://182.61.149.245/627921802949169152.jpg",
                            @"isRead": @"0",
                            @"isComment": @"1",
                            @"isCollect": @"1",
                            @"isForward": @"0",
                            @"isGuanfang": @"0",
                            @"readCount": @"123万",
                            @"commentCount": @"123万",
                            @"collectCount": @"123万",
                            @"forwardCount": @"123万",
                            @"shenpingAuthor": @"过去的门",
                            @"shenpingContent": @"展示获得赞更多的回",
                            @"isShenping": @"1"
                            };
    NSDictionary *dict3 = @{
                            @"authorImg": @"icon-logo-",
                            @"authorName": @"刘非特u124",
                            @"date": @"2019年10月21日 15:20",
                            @"days": @"3",
                            @"title": @"【分享好习惯】(标题自动换行，最多展示三行)",
                            @"content": @"每条动态，图片最多可以9张，但是完整显示的只有第一排的三张，剩下的第二排只显示一点点。内容可能很长，但如果超过了三行，就会变成省略号，比如我还没有说完比如我还没有说完比如我还没有说完",
                            @"imgs": @"http://182.61.149.245/627905544778289152.jpg,http://182.61.149.245/627905104128905216.jpg,http://182.61.149.245/627921802949169152.jpg,http://182.61.149.245/627905544778289152.jpg,http://182.61.149.245/627905104128905216.jpg,http://182.61.149.245/627921802949169152.jpg",
                            @"isRead": @"1",
                            @"isComment": @"1",
                            @"isCollect": @"1",
                            @"isForward": @"0",
                            @"isGuanfang": @"0",
                            @"readCount": @"123万",
                            @"commentCount": @"123万",
                            @"collectCount": @"123万",
                            @"forwardCount": @"123万",
                            @"isShenping": @"0",
                            @"shenpingAuthor": @"",
                            @"shenpingContent": @""
                            
                            };
    NSArray *arr1 = @[dict1, dict2, dict3];
    for (int i = 0; i < arr1.count; i++) {
        TLLvyouQuanModel *model = [TLLvyouQuanModel mj_objectWithKeyValues:arr1[i]];
        [self.arr addObject:model];
    }
}

-(TLBaseTableView *)tableView {
    if (!_tableView) {
        _tableView = [[TLBaseTableView alloc]initWithFrame:CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - J_TabBarHeight - 107 * layoutBy6()) style:UITableViewStylePlain];
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
