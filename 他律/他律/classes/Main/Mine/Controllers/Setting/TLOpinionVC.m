//
//  TLOpinionVC.m
//  他律
//
//  Created by sineboy on 2020/2/27.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLOpinionVC.h"
#import "UIImage+Extension.h"

@interface TLOpinionVC ()<UITextViewDelegate>

@property (nonatomic, strong) UITextView *reasonContentView;

@property (nonatomic, strong) UILabel *reasonContentViewPlaceholderLabel;

@property (nonatomic, strong) UIButton *submitBtn;

@end

@implementation TLOpinionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self creatLeftEnble];
    self.title = @"意见反馈";
    self.view.backgroundColor = hexStringToColor(@"ffffff");
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.reasonContentView];
    [self.reasonContentView addSubview:self.reasonContentViewPlaceholderLabel];
    [self.view addSubview:self.submitBtn];
    [self makeSubViewsConstraints];
}

-(void)makeSubViewsConstraints {
    self.reasonContentView.frame = CGRectMake(15 * layoutBy6(), 81 * layoutBy6() , J_SCREEN_WIDTH - 30 * layoutBy6() , 400 * layoutBy6() );
    self.reasonContentViewPlaceholderLabel.frame = CGRectMake(10 * layoutBy6(), 10 * layoutBy6(), self.reasonContentView.width - 20 * layoutBy6(), 50 * layoutBy6());
    self.submitBtn.frame = CGRectMake(15 * layoutBy6(), J_SCREEN_HEIGHT - 30 * layoutBy6() - 50 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 50 * layoutBy6());
}

-(void)rightUUserItem {
    
    if (self.reasonContentView.text.length == 0 || self.reasonContentView.text == nil) {
        [SVProgressHUD showErrorWithStatus:@"内容不能为空！"];
        [SVProgressHUD dismissWithDelay:1.5];
        return;
    }
    
    NSDictionary *dict = @{
                           @"userId": K_userInfo.userId,
                           @"context": self.reasonContentView.text
                           };
    
    [TLNetworking postRequestWithURL:post_saveFeedBack parameters:dict Progress:^(CGFloat progress) {
        
    } success:^(id responseObject) {
        
        if ([[responseObject objectForKey:@"flag"] integerValue] == 1) {
            [SVProgressHUD showSuccessWithStatus:@"提交成功！"];
            [SVProgressHUD dismissWithDelay:1.5];
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD dismissWithDelay:1.5];
        }
        
    } failure:^(NSError *error) {
        
    }];
    
}

#pragma mark - UIreasonContentViewDelegate


- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        self.reasonContentViewPlaceholderLabel.hidden = YES;
    }else {
        self.reasonContentViewPlaceholderLabel.hidden = NO;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 10 * layoutBy6();// 字体的行间距
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:15 * layoutBy6()],NSParagraphStyleAttributeName:paragraphStyle};
    textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.reasonContentView endEditing:YES];
}

-(UITextView *)reasonContentView {
    if (!_reasonContentView) {
        _reasonContentView = [[UITextView alloc] init];
        _reasonContentView.delegate = self;
        _reasonContentView.tag = 10;
        _reasonContentView.keyboardType = UIKeyboardTypeASCIICapable;
        _reasonContentView.backgroundColor = RGBA(245, 247, 251, 1);
    }
    return _reasonContentView;
}

-(UILabel *)reasonContentViewPlaceholderLabel {
    if (!_reasonContentViewPlaceholderLabel) {
        _reasonContentViewPlaceholderLabel = [[UILabel alloc] init];
        _reasonContentViewPlaceholderLabel.text = @"我们会很重视您的意见，您的意见可能会帮助到成千上万的律友";
        _reasonContentViewPlaceholderLabel.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        _reasonContentViewPlaceholderLabel.textColor = RGBA(153, 153, 153, 1);
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

        paragraphStyle.lineSpacing = 10 * layoutBy6();

        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];

        _reasonContentViewPlaceholderLabel.attributedText = [[NSAttributedString alloc] initWithString:_reasonContentViewPlaceholderLabel.text attributes:attributes];
        _reasonContentViewPlaceholderLabel.numberOfLines = 0;
    }
    return _reasonContentViewPlaceholderLabel;
}

-(UIButton *)submitBtn {
    if (!_submitBtn) {
        _submitBtn = [[UIButton alloc] init];
        _submitBtn.layer.cornerRadius = 5 * layoutBy6();
        _submitBtn.layer.masksToBounds = YES;
        UIColor *topleftColor = RGBA(36, 214, 78, 1);
        UIColor *bottomrightColor = RGBA(46, 186, 89, 1);
        CGSize size = CGSizeMake(J_SCREEN_WIDTH - 30 * layoutBy6(), 50 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [_submitBtn setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
//        _submitBtn.backgroundColor = hexStringToColor(@"");
        [_submitBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_submitBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        [_submitBtn addTarget:self action:@selector(rightUUserItem) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitBtn;
}

@end
