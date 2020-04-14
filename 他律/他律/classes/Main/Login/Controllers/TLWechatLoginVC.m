//
//  TLWechatLoginVC.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLWechatLoginVC.h"
#import "TLWechatLoginRootView.h"

@interface TLWechatLoginVC ()

@property (nonatomic, strong) TLWechatLoginRootView *rootView;

@end

@implementation TLWechatLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
}

-(void)setupSubViewUI {
    [self.view addSubview:self.rootView];
    
    [self makeSubViewsContraint];
}

-(void)didClickXieyiBtn:(UIButton *)sender {
    if (sender.tag == 10) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(50, 100, 200, 300);
        view.backgroundColor = [UIColor blueColor];
        [self.view addSubview:view];
    }else if (sender.tag == 20) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(50, 100, 200, 300);
        view.backgroundColor = [UIColor redColor];
        [self.view addSubview:view];
    }
}


-(void)makeSubViewsContraint {
    self.rootView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
}

-(void)didClickWithSomethingBtn:(UIButton *)sender {
    NSString *account = @"";
    NSString *password = @"";
    if ([account isEqualToString:@""] || [password isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Account and password cannot be empty！"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    NSDictionary *dict = @{
                           @"account": account,
                           @"password": password
                           };
    [TLNetworking postRequestWithURL:post_login parameters:dict Progress:^(CGFloat progress) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"flag"] integerValue] == 1) {
            K_userInfo.isLogin = YES;
            K_userInfo.userId = [[responseObject objectForKey:@"data"] objectForKey:@"userId"];
            K_userInfo.name = [[responseObject objectForKey:@"data"] objectForKey:@"name"];
            K_userInfo.headImg = [[responseObject objectForKey:@"data"] objectForKey:@"headImg"];
            [SVProgressHUD showSuccessWithStatus:@"login successful！"];
            [SVProgressHUD dismissWithDelay:1.5];
            AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [appdelegate gotoHome];
        }else {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
}

-(void)didClickmoreBtn:(UIButton *)btn {
    
}

-(TLWechatLoginRootView *)rootView {
    if (!_rootView) {
        _rootView = [[TLWechatLoginRootView alloc] init];
        _rootView.backgroundColor = hexStringToColor(@"ffffff");
        [_rootView.loginBtn addTarget:self action:@selector(didClickWithSomethingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rootView.moreLoginBtn addTarget:self action:@selector(didClickmoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rootView.fuwuxieyiBtn addTarget:self action:@selector(didClickXieyiBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rootView.yisishengmingBtn addTarget:self action:@selector(didClickXieyiBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rootView;
}

@end
