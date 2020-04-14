//
//  TLFaqiHuatiVC.m
//  他律
//
//  Created by sineboy on 2020/3/30.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLFaqiHuatiVC.h"
#import "TZImagePickerController.h"

#define MaxWordsCount 150    //最多能输入几个字
@interface TLFaqiHuatiVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *textView;

@property (nonatomic, strong) UILabel *textViewPlaceholderLabel;

@property (nonatomic, strong) UILabel *wordsCountLabel; //提示还可以输入多少个字

@property (nonatomic, strong) NSMutableArray *picArr;

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *addView;

@property (nonatomic, strong) CustomButton *addBtn;

@property (nonatomic, strong) UILabel *placeholderLbl;

@property (nonatomic, strong) UIView *lineV;

@property (nonatomic, strong) UIButton *commitBnt;

@property (nonatomic, copy) NSString *videoStr;

@property (nonatomic, strong) NSMutableArray *imgUrlStrArr;

@property (nonatomic, assign) NSInteger index;

@property (nonatomic, strong) TZImagePickerController *imagePickerVC;

@property (nonatomic, strong) NSMutableArray *photoArr;

@property (nonatomic, assign) BOOL isLockCommit; //锁定上传按钮

@property (nonatomic, strong) UIButton *subBtn;

@end

@implementation TLFaqiHuatiVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = hexStringToColor(@"ffffff");
    [self creatLeftEnble];
    self.title = @"发起话题";
    
}

-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.textView resignFirstResponder];
    [self.textView endEditing:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

//左navItem点击
- (void)leftItem {
//    __weak typeof(self)weakSelf = self;
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Are you sure you want to cancel the edit？" message:@"" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [SVProgressHUD dismissWithDelay:0.5];
//        [weakSelf dismissViewControllerAnimated:YES completion:nil];
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//
//    }];
//    [alert addAction:confirmAction];
//    [alert addAction:cancelAction];
//    [self presentViewController:alert animated:YES completion:nil];
    
}

-(void)rightItem {
    if (self.isLockCommit == YES) {
        return;
    }
    
    [self didClickCommitBtn];
}

//右navItem点击
- (void)didClickSubmitBtn {
    
    if (self.isLockCommit == YES) {
        return;
    }
    
    [self didClickCommitBtn];
}

-(void)setupSubViewUI {
    [self.view addSubview:self.textView];
    [self.textView addSubview:self.textViewPlaceholderLabel];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.addBtn];
    //布局子控件
    [self makeSubViewsConstraints];
    
}

-(void)makeSubViewsConstraints {
    self.textView.frame = CGRectMake(15, J_StatusBarAndNavBarHeight + 20, J_SCREEN_WIDTH - 30, 160);
    self.textViewPlaceholderLabel.frame = CGRectMake(5, 9, self.textView.width - 10, 15);
    self.scrollView.frame = CGRectMake(0, self.textView.bottom + 10, J_SCREEN_WIDTH, 102);
    self.addBtn.frame = CGRectMake(15 + self.picArr.count * (11 + 94), 8, 94, 94);
    self.addBtn.customView.frame = CGRectMake(20, 18, 54, 54);
    
    self.lineV.frame = CGRectMake(15, self.scrollView.bottom + 12, J_SCREEN_WIDTH - 30, 0.5);
    self.subBtn.frame = CGRectMake(J_SCREEN_WIDTH/2 - 250/2, self.lineV.bottom + 100, 250, 50);
}

#pragma mark - UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if ([textView.text isEqualToString:@""] || textView.text == nil) {
        self.textViewPlaceholderLabel.hidden = NO;
    }
    if (textView.text.length > 0 && textView.text.length < MaxWordsCount) {
        self.textViewPlaceholderLabel.hidden = YES;
        NSInteger length = textView.text.length;
        self.wordsCountLabel.text = [NSString stringWithFormat:@"You can also enter the %ld word!",MaxWordsCount-length];
    } else if (textView.text.length >= MaxWordsCount){
        self.wordsCountLabel.text = @"Note: Can't enter more!";
        [SVProgressHUD showInfoWithStatus:@"You can enter up to 150 words!"];
        textView.text = [textView.text substringToIndex:MaxWordsCount];
    } else {
        self.textViewPlaceholderLabel.hidden = NO;
        self.wordsCountLabel.text = @"Note: You can enter up to 150 words!";
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView endEditing:YES];
    [self.navigationController setNavigationBarHidden:NO];
    //[self.textView resignFirstResponder];
}


#pragma mark - 加载图片
-(void)showPhotoToScrollView {
    NSInteger count = self.picArr.count;
    for (int i = 0; i < count; i ++) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.frame = CGRectMake(15 + i * (94 + 11), 8, 94, 94);
        UIImage *image = self.picArr[i];
        
        imageV.image = image;
        imageV.contentMode = UIViewContentModeScaleAspectFill;
        imageV.clipsToBounds = YES;
        [self.scrollView addSubview:imageV];
        
        UIButton *deleteBtn = [[UIButton alloc] init];
        deleteBtn.frame = CGRectMake(imageV.left - 8, imageV.top - 8, 16, 16);
        [deleteBtn setBackgroundImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        [deleteBtn addTarget:self action:@selector(didClickDeletePhoto:) forControlEvents:UIControlEventTouchUpInside];
        deleteBtn.tag = i;
        [self.scrollView addSubview:deleteBtn];
    }
    self.addBtn.x = 15 + count * 105;
    self.scrollView.contentSize = CGSizeMake(15 + (count + 1) * 105, 0);
}



#pragma mark - 点击删除图片
-(void)didClickDeletePhoto:(UIButton *)sender {
    [self.picArr removeObjectAtIndex:sender.tag];
    
    [self.scrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.addBtn = ({
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(15 + self.picArr.count * (11 + 94), 8, 94, 94);
        [btn setBackgroundImage:[UIImage imageNamed:@"add_picture"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:btn];
        btn;
    });
    
    [self showPhotoToScrollView];
}

#pragma mark - 点击➕添加图片
-(void)openPhoto {
    if (self.picArr.count >= 4) {
        [SGInfoAlert showInfo:@"Can only upload 4 image at a time"];
        return;
    }
    
}


#pragma mark - 点击提交
-(void)didClickCommitBtn {
    
    if ([self.textView.text isEqualToString:@""]) {
        [SGInfoAlert showInfo:@"Please say something"];
        return;
    }
    if (self.picArr.count == 0) {
        [SGInfoAlert showInfo:@"Please select at least one image to upload"];
        return;
    }
    self.isLockCommit = YES;
    
    NSMutableString *imgs = [NSMutableString string];
    for (int i = 0; i < self.picArr.count; i++) {
        UIImage *image = self.picArr[i];
        
        NSData *imageData = UIImageJPEGRepresentation(image, 0.7);
        
        NSString *string = [Untils base64EncodedStringFrom:imageData];
        NSString *str1;
        str1 = [NSString stringWithFormat:@",%@",string];
        if (i == 0) {
            str1 = string;
        }
        [imgs appendString:str1];
    }
    
    NSDictionary *dict1 = @{
                            @"file": imgs
                            };
    [SVProgressHUD showWithStatus:@"Processing, please wait..."];
    [TLNetworking postRequestWithURL:post_processIO parameters:dict1 Progress:^(CGFloat progress) {
        
    } success:^(id responseObject) {
        self.isLockCommit =  NO;
        if ([[responseObject objectForKey:@"flag"] integerValue] == 1) {
            NSArray *imgDatas = [responseObject objectForKey:@"data"];
            NSMutableString *imgs2 = [NSMutableString string];
            for (int i = 0; i < imgDatas.count; i++) {
                
                NSString *string = imgDatas[i];
                NSString *str1;
                str1 = [NSString stringWithFormat:@",%@",string];
                if (i == 0) {
                    str1 = string;
                }
                [imgs2 appendString:str1];
            }
            NSDictionary *dict2 = @{
                                    @"userId": K_userInfo.userId,
                                    @"imgUrl": imgs2,
                                    @"context": self.textView.text
                                    };
            
            [TLNetworking postRequestWithURL:post_saveFriend parameters:dict2 Progress:^(CGFloat progress) {
                
            } success:^(id responseObject) {
                
                if ([[responseObject objectForKey:@"flag"] integerValue] == 1) {
                    [SVProgressHUD showSuccessWithStatus:@"Successfully released"];
                    [SVProgressHUD dismissWithDelay:1.5];
                    [self dismissViewControllerAnimated:YES completion:nil];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"gotoshow" object:nil];
                }else {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
                    [SVProgressHUD dismissWithDelay:1.5];
                }
            } failure:^(NSError *error) {
                self.isLockCommit =  NO;
                [SVProgressHUD showErrorWithStatus:@"Upload failed"];
                [SVProgressHUD dismissWithDelay:1.5];
            }];
        }else {
            self.isLockCommit =  NO;
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
    } failure:^(NSError *error) {
        self.isLockCommit =  NO;
        [SVProgressHUD showErrorWithStatus:@"Upload failed"];
        [SVProgressHUD dismissWithDelay:1.5];
    }];
}

-(TZImagePickerController *)imagePickerVC {
    if (!_imagePickerVC) {
        _imagePickerVC = [[TZImagePickerController alloc] init];
        _imagePickerVC.allowPickingImage = YES;
        _imagePickerVC.allowPickingVideo = YES;
        _imagePickerVC.allowTakePicture = YES;
    }
    return _imagePickerVC;
}

-(UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 5;
        _textView.layer.masksToBounds = YES;
        //        _textView.layer.borderColor = hexStringToColor(@"eeeeee").CGColor;
        //        _textView.layer.borderWidth = 1;
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.keyboardType = UIKeyboardTypeASCIICapable;
        _textView.textColor = hexStringToColor(@"1e0f02");
    }
    return _textView;
}

-(UILabel *)textViewPlaceholderLabel {
    if (!_textViewPlaceholderLabel) {
        _textViewPlaceholderLabel = [[UILabel alloc] init];
        _textViewPlaceholderLabel.text = @"Record this moment";
        _textViewPlaceholderLabel.font = [UIFont systemFontOfSize:14];
        _textViewPlaceholderLabel.textColor = hexStringToColor(@"c8c6c5");
    }
    return _textViewPlaceholderLabel;
}

-(UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}

-(CustomButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[CustomButton alloc] init];
        _addBtn.backgroundColor = hexStringToColor(@"eeeeee");
        _addBtn.customView.image = [UIImage imageNamed:@"add_pictures"];
        //[_addBtn setBackgroundImage:[UIImage imageNamed:@"add_picture"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(openPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}


-(UIView *)lineV {
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.backgroundColor = hexStringToColor(default_color);
    }
    return _lineV;
}




-(NSMutableArray *)photoArr {
    if (!_photoArr) {
        _photoArr = [NSMutableArray array];
    }
    return _photoArr;
}

-(NSMutableArray *)picArr {
    if (!_picArr) {
        _picArr = [NSMutableArray array];
    }
    return _picArr;
}

-(NSMutableArray *)imgUrlStrArr {
    if (!_imgUrlStrArr) {
        _imgUrlStrArr = [NSMutableArray array];
    }
    return _imgUrlStrArr;
}


-(UIButton *)subBtn {
    if (!_subBtn) {
        _subBtn = [[UIButton alloc] init];
        _subBtn.backgroundColor = hexStringToColor(default_color);
        _subBtn.layer.cornerRadius = 5;
        _subBtn.layer.masksToBounds = YES;
        [_subBtn setTitle:@"Submit" forState:UIControlStateNormal];
        [_subBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _subBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_subBtn addTarget:self action:@selector(didClickSubmitBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subBtn;
}

@end
