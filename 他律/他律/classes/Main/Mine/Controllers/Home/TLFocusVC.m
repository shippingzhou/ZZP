//
//  TLFocusVC.m
//  他律
//
//  Created by sineboy on 2020/2/27.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLFocusVC.h"

@interface TLFocusVC ()

@end

@implementation TLFocusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = hexStringToColor(@"ffffff");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    
}



@end
