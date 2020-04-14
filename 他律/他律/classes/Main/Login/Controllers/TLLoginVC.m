//
//  TLLoginVC.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLoginVC.h"
#import "TLLoginRootView.h"
#import "TLRegisterVC.h"
#import "TLVerifyCodeBtn.h"
#import "TLWechatLoginVC.h"
#import "TLCepingVC.h"
#import "TLHomepageVC.h"
#import "TLFirstLoginView.h"

@interface TLLoginVC ()

@property (nonatomic, strong) TLLoginRootView *genView;


@property (nonatomic, strong) TLFirstLoginView *firstView;

@end

@implementation TLLoginVC

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
    [self.view addSubview:self.genView];
    [self.view addSubview:self.firstView];
    self.firstView.nextBtnCallback = ^(id sender) {
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate gotoHome];
    };
    [self makeSubViewsContraint];
}

-(void)didClickCloseBtn {
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate gotoHome];
}

-(void)makeSubViewsContraint {
    self.genView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
    self.firstView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, J_SCREEN_HEIGHT);
}

-(void)didClickWithSomethingBtn:(UIButton *)sender {
    
    AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate gotoHome];
    return;
    
    [self.genView.accountField endEditing:YES];
    [self.genView.passwordField endEditing:YES];
    if (sender.tag == 10) {
        
        NSString *account = self.genView.accountField.text;
        NSString *password = self.genView.passwordField.text;
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
        
    }else if (sender.tag == 20) {
        TLRegisterVC *vc = [[TLRegisterVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 30) {
        AppDelegate * appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate gotoHome];
    }
}

-(void)didClickGetCodeBtn:(TLVerifyCodeBtn *)btn {
//    [btn timeFailBeginFrom:10];
//    TLWechatLoginVC *vc = [[TLWechatLoginVC alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    
    
//    TLCepingVC *vc = [[TLCepingVC alloc] init];
//    vc.count = 1;
//    [self.navigationController pushViewController:vc animated:YES];
    
    
//    NSDictionary *dict = @{
//                             @"phone": @"13008819454"
//                          };
//
//    NSString *jsonStr = [self ObjectTojsonString:dict];
//        [TLNetworking newPostRequestWithURL:post_getCode parameters:dict Progress:^(CGFloat progress) {
//
//        } success:^(id responseObject) {
//
//
//        } failure:^(NSError *error) {
//
//        }];
    
    self.firstView.hidden = NO;
}

-(NSString*)ObjectTojsonString:(id)object
{
NSString *jsonString = [[NSString
                         alloc]init];
NSError *error;
NSData *jsonData = [NSJSONSerialization
                    dataWithJSONObject:object
                    options:NSJSONWritingPrettyPrinted
                    error:&error];
if (! jsonData) {
    NSLog(@"error: %@", error);
} else {
    jsonString = [[NSString
                   alloc] initWithData:jsonData
                  encoding:NSUTF8StringEncoding];
}
NSMutableString *mutStr = [NSMutableString
                           stringWithString:jsonString];
NSRange range = {0,jsonString.length};
[mutStr replaceOccurrencesOfString:@" "
                        withString:@""
                           options:NSLiteralSearch range:range];
NSRange range2 = {0,mutStr.length};
[mutStr replaceOccurrencesOfString:@"\n"
                        withString:@""
                           options:NSLiteralSearch range:range2];
NSRange range3 = {0, mutStr.length};
NSString * str = @"\\";
[mutStr replaceOccurrencesOfString:str withString:@"" options:NSLiteralSearch range:range3];
return mutStr;
}

-(TLLoginRootView *)genView {
    if (!_genView) {
        _genView = [[TLLoginRootView alloc] init];
        _genView.backgroundColor = hexStringToColor(@"ffffff");
        [_genView.loginBtn addTarget:self action:@selector(didClickWithSomethingBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_genView.getCodeBtn addTarget:self action:@selector(didClickGetCodeBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _genView;
}

-(TLFirstLoginView *)firstView {
    if (!_firstView) {
        _firstView = [[TLFirstLoginView alloc] init];
        _firstView.hidden = YES;
    }
    return _firstView;
}

@end
