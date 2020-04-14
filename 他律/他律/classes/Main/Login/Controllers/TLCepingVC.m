//
//  TLCepingVC.m
//  他律
//
//  Created by sineboy on 2019/12/15.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLCepingVC.h"
#import "CustomButton.h"
#import "TLCepingResultVC.h"

@interface TLCepingVC ()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIView *bgView1;

@property (nonatomic, strong) UILabel *lbl1;

@property (nonatomic, strong) UIView *bgView2;

@property (nonatomic, strong) UILabel *lbl2;

@property (nonatomic, strong) UIView *bgView3;

@property (nonatomic, strong) UILabel *lbl3;

@property (nonatomic, strong) UILabel *selectedLbl;

@property (nonatomic, strong) UIButton *nextBtn;

@property (nonatomic, assign) CGFloat fenshu;

@end

@implementation TLCepingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测评";
    [self creatLeftEnble];
    self.view.backgroundColor = hexStringToColor(@"ffffff");
    // Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

-(void)setupSubViewUI {
    [self.view addSubview:self.titleLbl];
    [self.view addSubview:self.bgView1];
    [self.view addSubview:self.lbl1];
    [self.view addSubview:self.bgView2];
    [self.view addSubview:self.lbl2];
    [self.view addSubview:self.bgView3];
    [self.view addSubview:self.lbl3];
    [self.view addSubview:self.nextBtn];
    if (self.count == 1) {
        self.titleLbl.text = @"1、你觉得自己是否是一个对自己诚实的人？";
        self.lbl1.text = @"A 是";
        self.lbl2.text = @"B 不是";
    }else if (self.count == 2) {
        self.titleLbl.text = @"2、“要判断某人是个怎么样的人，光听他们怎么说是不够的，还要看他们怎么做。”你认同这句话吗？";
        self.lbl1.text = @"A 认同";
        self.lbl2.text = @"B 不认同";
    }else if (self.count == 3) {
        self.titleLbl.text = @"3、你有多少次想要改变自己，拥有更好的未来？";
        self.lbl1.text = @"A 很多时候";
        self.lbl2.text = @"B 从来没有";
    }else if (self.count == 4) {
        self.titleLbl.text = @"4、你是否想要加入一个充满正能量的圈子，并分享自己的正能量？";
        self.lbl1.text = @"A 想";
        self.lbl2.text = @"B 不想";
    }else if (self.count == 5) {
        self.titleLbl.text = @"5、如果每天花5分钟时间能换取一个更好的自己，更好的未来，你是否愿意？";
        self.lbl1.text = @"A 愿意";
        self.lbl2.text = @"B 不愿意";
    }else if (self.count == 6) {
        self.titleLbl.text = @"6、举手之劳，你是否愿意帮助别人？";
        self.lbl1.text = @"A 愿意";
        self.lbl2.text = @"B 不愿意";
    }else if (self.count == 7) {
        self.titleLbl.text = @"7、你使用“他律”APP的目标是什么？";
        self.lbl1.text = @"A 成为更好的自己，拥有一个更美好的未来";
        self.lbl2.text = @"B 随便逛逛社区，围观其他人改变自己";
    }else if (self.count == 8) {
        self.titleLbl.text = @"8、每天花五分钟用来改变自己，你觉得能坚持多长时间？";
        self.lbl1.text = @"A 一年以上";
        self.lbl2.text = @"B 6-12个月";
        self.lbl3.text = @"C 6个月以内";
        
    }else if (self.count == 9) {
        self.titleLbl.text = @"9、科学研究显示，将目标和行动进度公开，更容易实现目标。\n你是否愿意尽量将每天的改变分享到朋友圈？";
        self.lbl1.text = @"A 愿意，分享我的改变，还能帮助朋友一起变得更好";
        self.lbl2.text = @"B 不愿意，改变自我让我感到羞愧，我不敢公开";
    }else if (self.count == 10) {
        self.titleLbl.text = @"10、改变自我的过程中每个人都需要鼓励，你是否愿意为其他人点赞鼓励？";
        self.lbl1.text = @"A 愿意。助人为快乐之本";
        self.lbl2.text = @"B 不愿意。我也不需要别人鼓励我";
    }
    if (self.count == 8) {
        self.bgView3.hidden = NO;
        self.lbl3.hidden = NO;
    }else {
        self.bgView3.hidden = YES;
        self.lbl3.hidden = YES;
    }
    [self makeSubViewContraints];
}

-(void)didClickNextBtn:(UIButton *)btn {
    if (!self.selectedLbl) {
        [SGInfoAlert showInfo:@"请选择一个答案"];
        return;
    }
    K_userInfo.allFenshu += self.fenshu;
    if (self.count < 10) {
        TLCepingVC *vc = [[TLCepingVC alloc] init];
        vc.count = self.count + 1;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        TLCepingResultVC *vc = [[TLCepingResultVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)didClickSelectLbl:(UITapGestureRecognizer *)tap {
    UILabel *lbl = (UILabel *)tap.view;
    self.bgView1.backgroundColor = hexStringToColor(@"f5f5f5");
    self.bgView1.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
    self.bgView2.backgroundColor = hexStringToColor(@"f5f5f5");
    self.bgView2.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
    self.bgView3.backgroundColor = hexStringToColor(@"f5f5f5");
    self.bgView3.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
    self.selectedLbl.textColor = hexStringToColor(@"666666");
    self.selectedLbl = lbl;
//    self.selectedLbl.backgroundColor = hexStringToColor(@"EBF9ED");
    self.selectedLbl.textColor = hexStringToColor(@"26c239");
    if (lbl.tag == 10) {
        self.bgView1.backgroundColor = hexStringToColor(@"EBF9ED");
        self.bgView1.layer.borderColor = hexStringToColor(@"26c239").CGColor;
        if (self.count == 7) {
            self.fenshu = 40;
        }else if (self.count == 8) {
            self.fenshu = 30;
        }else if (self.count == 9) {
            self.fenshu = 20;
        }else if (self.count == 10) {
            self.fenshu = 10;
        }else {
            self.fenshu = 0;
        }
    }else if (lbl.tag == 20) {
        self.bgView2.backgroundColor = hexStringToColor(@"EBF9ED");
        self.bgView2.layer.borderColor = hexStringToColor(@"26c239").CGColor;
        if (self.count == 7) {
            self.fenshu = 10;
        }else if (self.count == 8) {
            self.fenshu = 10;
        }else if (self.count == 9) {
            self.fenshu = 10;
        }else {
            self.fenshu = 0;
        }
    }else if (lbl.tag == 30) {
        self.bgView3.backgroundColor = hexStringToColor(@"EBF9ED");
        self.bgView3.layer.borderColor = hexStringToColor(@"26c239").CGColor;
        if (self.count == 8) {
            self.fenshu = 10;
        }else {
            self.fenshu = 0;
        }
    }
}

-(void)makeSubViewContraints {
    NSInteger index = 11;
    CGFloat margin = 2.5 * layoutBy6();
    CGFloat width = (J_SCREEN_WIDTH - (9 * margin))/10;
    for (int i = 0; i < index; i++) {
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(i * (width + margin), 64, width, 2);
        if (i <= self.count - 1) {
            view.backgroundColor = hexStringToColor(@"26c239");
        }else {
            view.backgroundColor = hexStringToColor(@"f5f5f5");
        }
        [self.view addSubview:view];
    }
    CGFloat titleHeight = [[Untils defaultUntils] heightForString:self.titleLbl.text fontSize:16 * layoutBy6() andWidth:J_SCREEN_WIDTH - 50 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO];
    self.titleLbl.frame = CGRectMake(25 * layoutBy6(), 103 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), titleHeight);
    CGFloat lblHeight1 = [[Untils defaultUntils] heightForString:self.lbl1.text fontSize:14 * layoutBy6() andWidth:J_SCREEN_WIDTH - 50 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO];
    self.bgView1.frame = CGRectMake(25 * layoutBy6(), self.titleLbl.bottom + 20 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), lblHeight1 + 27 * layoutBy6());
    self.lbl1.frame = CGRectMake(45 * layoutBy6(), self.bgView1.top + 13.5 * layoutBy6(), J_SCREEN_WIDTH - 90 * layoutBy6(), lblHeight1);
    
    
    CGFloat lblHeight2 = [[Untils defaultUntils] heightForString:self.lbl2.text fontSize:14 * layoutBy6() andWidth:J_SCREEN_WIDTH - 90 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO];
    self.bgView2.frame = CGRectMake(25 * layoutBy6(), self.bgView1.bottom + 20 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), lblHeight2 + 27 * layoutBy6());
    self.lbl2.frame = CGRectMake(45 * layoutBy6(), self.bgView2.top + 13.5 * layoutBy6(), J_SCREEN_WIDTH - 90 * layoutBy6(), lblHeight2);
    
    CGFloat lblHeight3 = [[Untils defaultUntils] heightForString:self.lbl3.text fontSize:14 * layoutBy6() andWidth:J_SCREEN_WIDTH - 90 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO];
    self.bgView3.frame = CGRectMake(25 * layoutBy6(), self.bgView2.bottom + 20 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), lblHeight3 + 27 * layoutBy6());
    self.lbl3.frame = CGRectMake(45 * layoutBy6(), self.bgView3.top + 13.5 * layoutBy6(), J_SCREEN_WIDTH - 90 * layoutBy6(), lblHeight3);
    self.nextBtn.frame = CGRectMake(25 * layoutBy6(), J_SCREEN_HEIGHT - 19 * layoutBy6() - 45 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 45 * layoutBy6());
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:16 * layoutBy6()];
        _titleLbl.numberOfLines = 0;
    }
    return _titleLbl;
}

-(UIView *)bgView1 {
    if (!_bgView1) {
        _bgView1 = [[UIView alloc] init];
        _bgView1.layer.cornerRadius = 5;
        _bgView1.layer.masksToBounds = YES;
        _bgView1.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
        _bgView1.layer.borderWidth = 0.5;
        _bgView1.backgroundColor = hexStringToColor(@"f5f5f5");
    }
    return _bgView1;
}

-(UILabel *)lbl1 {
    if (!_lbl1) {
        _lbl1 = [[UILabel alloc] init];
//        _lbl1.backgroundColor = hexStringToColor(@"f5f5f5");
        _lbl1.textColor = hexStringToColor(@"666666");
        _lbl1.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _lbl1.numberOfLines = 0;
        _lbl1.tag = 10;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelectLbl:)];
        [_lbl1 addGestureRecognizer:tap];
        _lbl1.userInteractionEnabled = YES;
    }
    return _lbl1;
}

-(UIView *)bgView2 {
    if (!_bgView2) {
        _bgView2 = [[UIView alloc] init];
        _bgView2.layer.cornerRadius = 5;
        _bgView2.layer.masksToBounds = YES;
        _bgView2.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
        _bgView2.layer.borderWidth = 0.5;
        _bgView2.backgroundColor = hexStringToColor(@"f5f5f5");
    }
    return _bgView2;
}

-(UILabel *)lbl2 {
    if (!_lbl2) {
        _lbl2 = [[UILabel alloc] init];
//        _lbl2.backgroundColor = hexStringToColor(@"f5f5f5");
        _lbl2.textColor = hexStringToColor(@"666666");
        _lbl2.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _lbl2.numberOfLines = 0;
        _lbl2.tag = 20;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelectLbl:)];
        [_lbl2 addGestureRecognizer:tap];
        _lbl2.userInteractionEnabled = YES;
    }
    return _lbl2;
}

-(UIView *)bgView3 {
    if (!_bgView3) {
        _bgView3 = [[UIView alloc] init];
        _bgView3.layer.cornerRadius = 5;
        _bgView3.layer.masksToBounds = YES;
        _bgView3.layer.borderColor = hexStringToColor(@"ffffff").CGColor;
        _bgView3.layer.borderWidth = 0.5;
        _bgView3.backgroundColor = hexStringToColor(@"f5f5f5");
    }
    return _bgView3;
}

-(UILabel *)lbl3 {
    if (!_lbl3) {
        _lbl3 = [[UILabel alloc] init];
        //        _lbl2.backgroundColor = hexStringToColor(@"f5f5f5");
        _lbl3.textColor = hexStringToColor(@"666666");
        _lbl3.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _lbl3.numberOfLines = 0;
        _lbl3.tag = 30;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelectLbl:)];
        [_lbl3 addGestureRecognizer:tap];
        _lbl3.userInteractionEnabled = YES;
    }
    return _lbl3;
}

-(UIButton *)nextBtn {
    if (!_nextBtn) {
        _nextBtn = [[UIButton alloc] init];
        _nextBtn.layer.cornerRadius = 10;
        _nextBtn.layer.masksToBounds = YES;
        [_nextBtn setBackgroundColor:hexStringToColor(@"24d64e")];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _nextBtn.titleLabel.font = [UIFont systemFontOfSize:18 * layoutBy6()];
        [_nextBtn addTarget:self action:@selector(didClickNextBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextBtn;
}

@end
