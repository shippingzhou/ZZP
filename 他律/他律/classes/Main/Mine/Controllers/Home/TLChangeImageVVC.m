//
//  TLChangeImageVVC.m
//  他律
//
//  Created by sineboy on 2019/12/25.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLChangeImageVVC.h"
#import "HXPhotoViewController.h"

@interface TLChangeImageVVC ()<HXPhotoViewControllerDelegate>

@property (nonatomic, strong) UIImageView *imageGLoofeelgView;

@property (nonatomic, copy) NSString *sign;

@property (nonatomic, copy) NSString *directory;

@property (strong, nonatomic) HXPhotoManager *pictureGLoofeelgManager;

@property (strong, nonatomic) HXPhotoManager *cameraGLoofeelgManager;

@end

@implementation TLChangeImageVVC


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人头像";
    self.view.backgroundColor = hexStringToColor(@"ffffff");
    [self creatLeftEnble];
    [self creatRightWithString:@"更多" withHex:@"333333" withFontStr:15 * layoutBy6()];
    self.view.backgroundColor = hexStringToColor(@"1e0f02");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.imageGLoofeelgView];
    // 添加子控件的约束
    [self makeSubViewsConstraints];
}

-(void)makeSubViewsConstraints {
    // __weak typeof(self)weakSelf = self;
    self.imageGLoofeelgView.frame = CGRectMake(0, J_StatusBarAndNavBarHeight + 100, J_SCREEN_WIDTH, 375);
}

//右navItem点击
- (void)rightItem {
    
    [self callActionSheetFunc];
}

/**
 @ 调用ActionSheet
 */
- (void)callActionSheetFunc{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"Select Image" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Take a photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
        vc.manager = self.cameraGLoofeelgManager;
        vc.delegate = self;
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    }];
    UIAlertAction *albumAction = [UIAlertAction actionWithTitle:@"Choose from album" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        HXPhotoViewController *vc = [[HXPhotoViewController alloc] init];
        vc.manager = self.pictureGLoofeelgManager;
        vc.delegate = self;
        
        [self presentViewController:[[UINavigationController alloc] initWithRootViewController:vc] animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alertVC addAction:cameraAction];
    [alertVC addAction:albumAction];
    [alertVC addAction:cancelAction];
    [self presentViewController:alertVC animated:YES completion:nil];
}

//照片和视频回调
- (void)photoViewControllerDidNext:(NSArray<HXPhotoModel *> *)allList Photos:(NSArray<HXPhotoModel *> *)photos Videos:(NSArray<HXPhotoModel *> *)videos Original:(BOOL)original {
    __weak typeof(self) weakSelf = self;
    
    [HXPhotoTools getImageForSelectedPhoto:photos type:0 completion:^(NSArray<UIImage *> *images) {
        
        UIImage *image = images.firstObject;
        weakSelf.imageGLoofeelgView.image = image;
        NSData *imgedata =UIImageJPEGRepresentation(image, 0.7);
        
        NSString *imgStr = [Untils base64EncodedStringFrom:imgedata];
        NSDictionary *dict1 = @{
                                @"file": imgStr
                                };
        
        [TLNetworking postRequestWithURL:post_processIO parameters:dict1 Progress:^(CGFloat progress) {
            
        } success:^(id responseObject1) {
            
            if ([[responseObject1 objectForKey:@"flag"] integerValue] == 1) {
                NSArray *imgAarr = [responseObject1 objectForKey:@"data"];
                NSString *newImg = imgAarr.firstObject;
                K_userInfo.headImg = newImg;
                NSDictionary *dict2 = @{
                                        @"userId": K_userInfo.userId,
                                        @"img": newImg
                                        };
                [TLNetworking postRequestWithURL:post_updateImg parameters:dict2 Progress:^(CGFloat progress) {
                    
                } success:^(id responseObject2) {
                    
                    if ([[responseObject2 objectForKey:@"flag"] integerValue] == 1) {
                        NSLog(@"成功了.");
                        //[self.imageGLoofeelgView sd_setImageWithURL:[NSURL URLWithString:K_userInfo.headImg]];
                    }else {
                        [SVProgressHUD showErrorWithStatus:[responseObject2 objectForKey:@"message"]];
                        [SVProgressHUD dismissWithDelay:1.5];
                    }
                } failure:^(NSError *error) {
                    
                }];
            }else {
                [SVProgressHUD showErrorWithStatus:[responseObject1 objectForKey:@"message"]];
                [SVProgressHUD dismissWithDelay:1.5];
            }
        } failure:^(NSError *error) {
            
        }];
    }];
}

-(UIImageView *)imageGLoofeelgView {
    if (!_imageGLoofeelgView) {
        _imageGLoofeelgView = [[UIImageView alloc] init];
        NSString *imgStr = K_userInfo.headImg;
        
        [_imageGLoofeelgView sd_setImageWithURL:[NSURL URLWithString:imgStr]];
    }
    return _imageGLoofeelgView;
}

- (HXPhotoManager *)pictureGLoofeelgManager {
    if (!_pictureGLoofeelgManager) {
        _pictureGLoofeelgManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _pictureGLoofeelgManager.openCamera = YES;
        _pictureGLoofeelgManager.singleSelected = YES;
        _pictureGLoofeelgManager.showFullScreenCamera = YES;
    }
    return _pictureGLoofeelgManager;
}

- (HXPhotoManager *)cameraGLoofeelgManager {
    if (!_cameraGLoofeelgManager) {
        _cameraGLoofeelgManager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhoto];
        _cameraGLoofeelgManager.goCamera = YES;
        _cameraGLoofeelgManager.singleSelected = YES;
        _cameraGLoofeelgManager.showFullScreenCamera = YES;
    }
    return _cameraGLoofeelgManager;
}


@end
