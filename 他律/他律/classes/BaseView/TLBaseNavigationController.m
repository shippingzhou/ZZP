//
//  TLBaseNavigationController.m
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLBaseNavigationController.h"

@interface TLBaseNavigationController ()

@end

@implementation TLBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setBarTintColor:hexStringToColor(@"ffffff")];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:hexStringToColor(@"333333")}];
    [self.navigationBar setTintColor:[UIColor blackColor]];
}

@end
