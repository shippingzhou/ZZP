//
//  TLBaseViewController.h
//  他律
//
//  Created by sineboy on 2019/12/12.
//  Copyright © 2019 com. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TLBaseViewController : UIViewController

- (void)setupSubViewUI;

- (void)creatLeftEnble;

- (void)creatRightWithString:(NSString *)str withHex:(NSString *)hex withFontStr:(CGFloat)fontStr;

- (void)leftItem;

- (void)rightItem;

@end

NS_ASSUME_NONNULL_END
