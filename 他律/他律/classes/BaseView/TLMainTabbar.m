//
//  TLMainTabbar.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMainTabbar.h"
#import "TLHomepageVC.h"
#import "TLLvYouQuanVC.h"
#import "TLWodeDakaVC.h"
#import "TLMineVC.h"

@interface TLMainTabbar ()<UITabBarDelegate,UITabBarControllerDelegate>


@end

@implementation TLMainTabbar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatView];
}

-(void)creatView {
    UIColor *highLightColor = hexStringToColor(@"26c239");
    [self.tabBar setBarTintColor:[UIColor whiteColor]];
    self.delegate = self;

    TLHomepageVC *homepageVC = [[TLHomepageVC alloc]init];
    TLBaseNavigationController *homepageNavi = [[TLBaseNavigationController alloc]initWithRootViewController:homepageVC];
    UITabBarItem *homepageItem = [[UITabBarItem alloc]initWithTitle:@"首页"
                                                                             image:[[UIImage imageNamed:@"icon-sy-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon-sy"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [homepageItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:highLightColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [homepageNavi setTabBarItem:homepageItem];

    //
    TLLvYouQuanVC *lvyouQuanVC = [[TLLvYouQuanVC alloc]init];
    TLBaseNavigationController *lvyouQuanNavi = [[TLBaseNavigationController alloc]initWithRootViewController:lvyouQuanVC];

    UITabBarItem *lvyouQuanItem = [[UITabBarItem alloc]initWithTitle:@"律友圈" image:[[UIImage imageNamed:@"icon-hdsz"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon-hdsz-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [lvyouQuanItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:highLightColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [lvyouQuanNavi setTabBarItem:lvyouQuanItem];
    
    TLWodeDakaVC *wodeDakaVC = [[TLWodeDakaVC alloc]init];
    TLBaseNavigationController *wodeDakaNavi = [[TLBaseNavigationController alloc]initWithRootViewController:wodeDakaVC];
    
    UITabBarItem *wodeDakaItem = [[UITabBarItem alloc]initWithTitle:@"我的打卡" image:[[UIImage imageNamed:@"icon-wdrk"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon_wdrk_"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [wodeDakaItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:highLightColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [wodeDakaNavi setTabBarItem:wodeDakaItem];

    //
    TLMineVC *mineVC = [[TLMineVC alloc]init];
    TLBaseNavigationController *mineNavi = [[TLBaseNavigationController alloc]initWithRootViewController:mineVC];

    UITabBarItem *mineItem = [[UITabBarItem alloc]initWithTitle:@"个人中心" image:[[UIImage imageNamed:@"icon-grzx"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] selectedImage:[[UIImage imageNamed:@"icon-grzx-"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    [mineItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:highLightColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [mineNavi setTabBarItem:mineItem];

    self.viewControllers = [NSArray arrayWithObjects:homepageNavi,lvyouQuanNavi,wodeDakaNavi,mineNavi, nil];
    self.selectedIndex = 3;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getNotification:) name:@"gotoshow" object:nil];
}

-(void)getNotification:(NSNotification *)notification {
    self.selectedIndex = 0;
//    [self.homepageVC getContenListData:YES];
//    [self.mineVC getContent];
}

#pragma mark - 设置父控件半透明，子控件不透明
//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
//
//    if (viewController == [tabBarController.viewControllers objectAtIndex:1] || viewController == [tabBarController.viewControllers objectAtIndex:2]) {
//        if (K_userInfo.isLogin == NO) {
//            MSLoginasldkajhlgkajlVC *vc = [[MSLoginasldkajhlgkajlVC alloc] init];
//            TLBaseNavigationController *nav = [[TLBaseNavigationController alloc] initWithRootViewController:vc];
//            [self presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }
//        if (viewController == [tabBarController.viewControllers objectAtIndex:1]) {
//            MSUploadasdasklhkjgaklVC *uploadVC = [[MSUploadasdasklhkjgaklVC alloc] init];
//            //uploadVC.isNew = YES;
//            TLBaseNavigationController *nav = [[TLBaseNavigationController alloc] initWithRootViewController:uploadVC];
//            [self presentViewController:nav animated:YES completion:nil];
//            return NO;
//        }else {
//            return YES;
//        }
//    }else {
//        return YES;
//    }
//}

@end
