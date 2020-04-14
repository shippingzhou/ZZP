//
//  TLPersonalCenterHeadView.m
//  他律
//
//  Created by sineboy on 2020/2/10.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLPersonalCenterHeadView.h"

@interface TLPersonalCenterHeadView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *leftBtn;

@property (nonatomic, strong) UIButton *focusBtn;

@property (nonatomic, strong) UIButton *laheiBtn;

@property (nonatomic, strong) UIImageView *authorView;

@property (nonatomic, strong) UILabel *authorLbl;

@property (nonatomic, strong) UILabel *personalLbl;

@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, strong) UILabel *likeText;

@property (nonatomic, strong) UILabel *commentText;

@property (nonatomic, strong) UILabel *dayText;

@property (nonatomic, strong) UILabel *likeCount;

@property (nonatomic, strong) UILabel *commentCount;

@property (nonatomic, strong) UILabel *dayCount;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIView *titleView;

@property (nonatomic, strong) NSArray *titleArr;

@property (nonatomic, strong) UIButton *selectedBtn;

@property (nonatomic, strong) UIView *selectedLine;

@end

@implementation TLPersonalCenterHeadView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.leftBtn];
    [self addSubview:self.focusBtn];
    [self addSubview:self.laheiBtn];
    [self addSubview:self.authorView];
    [self addSubview:self.authorLbl];
    [self addSubview:self.personalLbl];
    [self addSubview:self.rightView];
    [self addSubview:self.likeCount];
    [self addSubview:self.likeText];
    [self addSubview:self.commentCount];
    [self addSubview:self.commentText];
    [self addSubview:self.dayCount];
    [self addSubview:self.dayText];
    [self addSubview:self.lineView];
    [self addSubview:self.titleView];
     [self setupTittleView];
//    [self makeSubViewContraint];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 236 * layoutBy6());
    self.leftBtn.frame = CGRectMake(10, J_StatusBarHeight + 10, 15, 18);
    self.focusBtn.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 54 * layoutBy6(), 68 * layoutBy6(), 54 * layoutBy6(), 20 * layoutBy6());
    self.laheiBtn.frame = CGRectMake(self.focusBtn.left - 10 * layoutBy6() - 44 * layoutBy6(), self.focusBtn.top, 44 * layoutBy6(), 20 * layoutBy6());
    self.authorView.frame = CGRectMake(16 * layoutBy6(), 74 * layoutBy6(), 50 * layoutBy6(), 50 * layoutBy6());
    self.authorLbl.frame = CGRectMake(self.authorView.right + 10.5 * layoutBy6(), self.authorView.top, 200 * layoutBy6(), 14 * layoutBy6());
    CGFloat heigth = [[Untils defaultUntils] heightForString:self.personalLbl.text fontSize:10 * layoutBy6() andWidth:245 * layoutBy6() andHeight:25 * layoutBy6() isBoldMT:NO];
    if (heigth > 15 * layoutBy6()) {
        self.personalLbl.frame = CGRectMake(self.authorLbl.left, self.authorLbl.bottom + 14 * layoutBy6(), 245 * layoutBy6(), 25 * layoutBy6());
    }else {
        self.personalLbl.frame = CGRectMake(self.authorLbl.left, self.authorLbl.bottom + 14 * layoutBy6(), 245 * layoutBy6(), 12 * layoutBy6());
    }
    
    self.rightView.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 8.5 * layoutBy6(), 91.5 * layoutBy6(), 8.5 * layoutBy6(), 15 * layoutBy6());
    CGFloat width = J_SCREEN_WIDTH/3;
    self.likeCount.frame = CGRectMake(0, self.authorView.bottom + 20.5 * layoutBy6(), width, 10 * layoutBy6());
    self.likeText.frame = CGRectMake(self.likeCount.left, self.likeCount.bottom + 7 * layoutBy6(), self.likeCount.width, 9.5 * layoutBy6());
    
    self.commentCount.frame = CGRectMake(width, self.likeCount.top, width, 10 * layoutBy6());
    self.commentText.frame = CGRectMake(self.commentCount.left, self.commentCount.bottom + 7 * layoutBy6(), self.commentCount.width, 9.5 * layoutBy6());
    
    self.dayCount.frame = CGRectMake(width * 2, self.likeCount.top + 3 * layoutBy6(), width, 10 * layoutBy6());
    self.dayText.frame = CGRectMake(self.dayCount.left, self.dayCount.bottom + 7 * layoutBy6(), self.dayCount.width, 9.5 * layoutBy6());
    self.lineView.frame = CGRectMake(0, 181 * layoutBy6(), J_SCREEN_WIDTH, 0.5);
    self.titleView.frame = CGRectMake(0, self.lineView.bottom, J_SCREEN_WIDTH, 44.5 * layoutBy6());
   
}

-(void)setupTittleView {
    NSInteger count = self.titleArr.count;
    CGFloat width = J_SCREEN_WIDTH/count;
    
    for (int i = 0; i < count; i++) {
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(i * width, 0, width, 44.5 * layoutBy6());
        [btn setTitle:self.titleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:hexStringToColor(@"333333") forState:UIControlStateNormal];
        [btn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateSelected];
        btn.titleLabel.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        [btn addTarget:self action:@selector(didClickTitleBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.titleView addSubview:btn];
        if (i == 0) {
            self.selectedBtn = btn;
            self.selectedBtn.selected = YES;
            self.selectedLine = [[UIView alloc] init];
            
            self.selectedLine.frame = CGRectMake(width/2 - 50/2 * layoutBy6(), 34 * layoutBy6(), 50 * layoutBy6(), 1 * layoutBy6());
            self.selectedLine.backgroundColor = hexStringToColor(@"26c239");
            [self.titleView addSubview:self.selectedLine];
        }
    }
}

-(void)didClickTitleBtn:(UIButton *)btn {
    self.selectedBtn.selected = NO;
    self.selectedBtn = btn;
    self.selectedBtn.selected = YES;
    NSInteger count = self.titleArr.count;
    CGFloat width = J_SCREEN_WIDTH/count;
    [UIView animateWithDuration:0.4 animations:^{
        self.selectedLine.left = btn.left + width/2 - 50/2 * layoutBy6();
    }];
}

-(void)didClickLeftBtn {
    if (self.leftBtnCallBack) {
        self.leftBtnCallBack(@(1));
    }
}

-(void)didClickfocusBtn {
    
}

-(void)didClicklaheiBtn {
    
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIButton *)leftBtn {
    if (!_leftBtn) {
        _leftBtn = [[UIButton alloc] init];
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    }
    return _leftBtn;
}

-(UIImageView *)authorView {
    if (!_authorView) {
        _authorView = [[UIImageView alloc] init];
        _authorView.layer.cornerRadius = 25 * layoutBy6();
        _authorView.layer.masksToBounds = YES;
        _authorView.image = [UIImage imageNamed:@"icon-logo-"];
    }
    return _authorView;
}

-(UILabel *)authorLbl {
    if (!_authorLbl) {
        _authorLbl = [[UILabel alloc] init];
        _authorLbl.text = @"奋斗者U1388";
        _authorLbl.textColor = hexStringToColor(@"333333");
        _authorLbl.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        _authorLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _authorLbl;
}

-(UILabel *)personalLbl {
    if (!_personalLbl) {
        _personalLbl = [[UILabel alloc] init];
        _personalLbl.text = @"人生终需一次妄想，带领我们去那从未到过的地方。如果个性签名内容太长，吧啦吧就......";
        _personalLbl.textColor = hexStringToColor(@"666666");
        _personalLbl.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _personalLbl.textAlignment = NSTextAlignmentLeft;
        _personalLbl.numberOfLines = 2;
    }
    return _personalLbl;
}

-(UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"icon-xyb"];
    }
    return _rightView;
}

-(UIButton *)focusBtn {
    if (!_focusBtn) {
        _focusBtn = [[UIButton alloc] init];
        _focusBtn.layer.cornerRadius = 2 * layoutBy6();
        _focusBtn.layer.masksToBounds = YES;
        _focusBtn.layer.borderColor = hexStringToColor(@"26c239").CGColor;
        _focusBtn.layer.borderWidth = 1 * layoutBy6();
        _focusBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        [_focusBtn setTitle:@"+关注" forState:UIControlStateNormal];
        [_focusBtn setTitleColor:hexStringToColor(@"26c239") forState:UIControlStateNormal];
        [_focusBtn addTarget:self action:@selector(didClickfocusBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _focusBtn;
}

-(UIButton *)laheiBtn {
    if (!_laheiBtn) {
        _laheiBtn = [[UIButton alloc] init];
        _laheiBtn.layer.cornerRadius = 2 * layoutBy6();
        _laheiBtn.layer.masksToBounds = YES;
        _laheiBtn.layer.borderColor = hexStringToColor(@"333333").CGColor;
        _laheiBtn.layer.borderWidth = 1 * layoutBy6();
        _laheiBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        [_laheiBtn setTitle:@"拉黑" forState:UIControlStateNormal];
        [_laheiBtn setTitleColor:hexStringToColor(@"333333") forState:UIControlStateNormal];
        [_laheiBtn addTarget:self action:@selector(didClicklaheiBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _laheiBtn;
}

-(UILabel *)likeCount {
    if (!_likeCount) {
        _likeCount = [[UILabel alloc] init];
        _likeCount.text = @"12425";
        _likeCount.textColor = hexStringToColor(@"333333");
        _likeCount.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _likeCount.textAlignment = NSTextAlignmentCenter;
    }
    return _likeCount;
}

-(UILabel *)likeText {
    if (!_likeText) {
        _likeText = [[UILabel alloc] init];
        _likeText.text = @"获赞";
        _likeText.textColor = hexStringToColor(@"666666");
        _likeText.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _likeText.textAlignment = NSTextAlignmentCenter;
    }
    return _likeText;
}

-(UILabel *)commentCount {
    if (!_commentCount) {
        _commentCount = [[UILabel alloc] init];
        _commentCount.text = @"19098";
        _commentCount.textColor = hexStringToColor(@"333333");
        _commentCount.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _commentCount.textAlignment = NSTextAlignmentCenter;
    }
    return _commentCount;
}

-(UILabel *)commentText {
    if (!_commentText) {
        _commentText = [[UILabel alloc] init];
        _commentText.text = @"获评论";
        _commentText.textColor = hexStringToColor(@"666666");
        _commentText.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _commentText.textAlignment = NSTextAlignmentCenter;
    }
    return _commentText;
}

-(UILabel *)dayCount {
    if (!_dayCount) {
        _dayCount = [[UILabel alloc] init];
//        _dayCount.textColor = hexStringToColor(@"333333");
//        _dayCount.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _dayCount.textAlignment = NSTextAlignmentCenter;
    }
    return _dayCount;
}

-(UILabel *)dayText {
    if (!_dayText) {
        _dayText = [[UILabel alloc] init];
        _dayText.text = @"累计打卡";
        _dayText.textColor = hexStringToColor(@"666666");
        _dayText.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _dayText.textAlignment = NSTextAlignmentCenter;
    }
    return _dayText;
}

-(UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = hexStringToColor(@"e9e9e9");
    }
    return _lineView;
}

-(UIView *)titleView {
    if (!_titleView) {
        _titleView = [[UIView alloc] init];
    }
    return _titleView;
}

-(NSArray *)titleArr {
    if (!_titleArr) {
        _titleArr = @[@"他的计划", @"他的打卡", @"他的话题", @"他的测评"];
    }
    return _titleArr;
}

@end
