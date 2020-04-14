//
//  TLRegisterVC.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLRegisterVC.h"
#import "TLRegisterRootView.h"

@interface TLRegisterVC ()

@property (nonatomic, strong) TLRegisterRootView *genView;

@end

@implementation TLRegisterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.genView];
    
    [self makeSubViewsContraint];
}

-(void)makeSubViewsContraint {
    self.genView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT - 0);
}

-(void)didClickBackClick {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)didClickRegistWithSomething {
    if ([self.genView.zhanghaoField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Account cannot be empty！"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    if ([self.genView.passwordField.text isEqualToString:@""]) {
        [SVProgressHUD showErrorWithStatus:@"Password can not be empty！"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    NSString *account = self.genView.zhanghaoField.text;
    NSString *password = self.genView.passwordField.text;
    
    NSDictionary *dict = @{
                           @"account": account,
                           @"password": password
                           };
    
    [TLNetworking postRequestWithURL:post_regist parameters:dict Progress:^(CGFloat progress) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"flag"] integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"Registration is successful, please login again！"];
            [SVProgressHUD dismissWithDelay:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    } failure:^(NSError *error) {
        
    }];
    
}

-(TLRegisterRootView *)genView {
    if (!_genView) {
        _genView = [[TLRegisterRootView alloc] init];
        [_genView.registBtn addTarget:self action:@selector(didClickRegistWithSomething) forControlEvents:UIControlEventTouchUpInside];
        [_genView.leftBtn addTarget:self action:@selector(didClickBackClick) forControlEvents:UIControlEventTouchUpInside];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yingsixieyi:)];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(yingsixieyi:)];
        [_genView.yingsiLbl addGestureRecognizer:tap1];
        _genView.yingsiLbl.userInteractionEnabled = YES;
        [_genView.xieyiLbl addGestureRecognizer:tap2];
        _genView.xieyiLbl.userInteractionEnabled = YES;
    }
    return _genView;
}

@end
