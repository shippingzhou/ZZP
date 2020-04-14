//
//  TLMineHeadView.m
//  他律
//
//  Created by sineboy on 2019/12/24.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMineHeadView.h"

@interface TLMineHeadView ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *settingBtn;

@property (nonatomic, strong) UIButton *emailBtn;

@property (nonatomic, strong) UIImageView *authorView;

@property (nonatomic, strong) UILabel *authorLbl;

@property (nonatomic, strong) UILabel *personalLbl;

@property (nonatomic, strong) UIImageView *rightView;


@property (nonatomic, strong) UILabel *likeText;


@property (nonatomic, strong) UILabel *commentText;


@property (nonatomic, strong) UILabel *dayText;

@end

@implementation TLMineHeadView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.bgView];
    [self addSubview:self.settingBtn];
    [self addSubview:self.emailBtn];
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
//    [self makeSubViewContraint];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0, J_SCREEN_WIDTH, 182 * layoutBy6());
    self.settingBtn.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 18 * layoutBy6(), 33 * layoutBy6(), 18 * layoutBy6(), 18 * layoutBy6());
    self.emailBtn.frame = CGRectMake(self.settingBtn.left - 15 * layoutBy6() - 18 * layoutBy6(), self.settingBtn.top + 1.5 * layoutBy6(), 18 * layoutBy6(), 15 * layoutBy6());
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
}

-(void)didClickEmailBtn {
    if (self.emailEditCallback) {
        self.emailEditCallback(@(1));
    }
}

-(void)didClickSettingBtn {
    if (self.settingEditCallback) {
        self.settingEditCallback(@(1));
    }
}

-(void)didClickPersonalBtn {
    if (self.personalEditCallback) {
        self.personalEditCallback(@(1));
    }
}

-(void)didClickLikeBtn {
    if (self.likeEditCallback) {
        self.likeEditCallback(@(1));
    }
}

-(void)didClickCommentBtn {
    if (self.commentEditCallback) {
        self.commentEditCallback(@(1));
    }
}

-(void)didClickDayBtn {
    if (self.dayEditCallback) {
        self.dayEditCallback(@(1));
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIImageView *)authorView {
    if (!_authorView) {
        _authorView = [[UIImageView alloc] init];
        _authorView.layer.cornerRadius = 25 * layoutBy6();
        _authorView.layer.masksToBounds = YES;
        _authorView.image = [UIImage imageNamed:@"icon-logo-"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonalBtn)];
        [_authorView addGestureRecognizer:tap];
        _authorView.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonalBtn)];
        [_authorLbl addGestureRecognizer:tap];
        _authorLbl.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonalBtn)];
        [_personalLbl addGestureRecognizer:tap];
        _personalLbl.userInteractionEnabled = YES;
    }
    return _personalLbl;
}

-(UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"icon-xyb"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonalBtn)];
        [_rightView addGestureRecognizer:tap];
        _rightView.userInteractionEnabled = YES;
    }
    return _rightView;
}

-(UIButton *)settingBtn {
    if (!_settingBtn) {
        _settingBtn = [[UIButton alloc] init];
        [_settingBtn setBackgroundImage:[UIImage imageNamed:@"icon-shez"] forState:UIControlStateNormal];
        [_settingBtn addTarget:self action:@selector(didClickSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settingBtn;
}

-(UIButton *)emailBtn {
    if (!_emailBtn) {
        _emailBtn = [[UIButton alloc] init];
        [_emailBtn setBackgroundImage:[UIImage imageNamed:@"icon-youjian"] forState:UIControlStateNormal];
        [_emailBtn addTarget:self action:@selector(didClickEmailBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emailBtn;
}

-(UILabel *)likeCount {
    if (!_likeCount) {
        _likeCount = [[UILabel alloc] init];
        _likeCount.text = @"12425";
        _likeCount.textColor = hexStringToColor(@"333333");
        _likeCount.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _likeCount.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLikeBtn)];
        [_likeCount addGestureRecognizer:tap];
        _likeCount.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickLikeBtn)];
        [_likeText addGestureRecognizer:tap];
        _likeText.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCommentBtn)];
        [_commentCount addGestureRecognizer:tap];
        _commentCount.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCommentBtn)];
        [_commentText addGestureRecognizer:tap];
        _commentText.userInteractionEnabled = YES;
    }
    return _commentText;
}

-(UILabel *)dayCount {
    if (!_dayCount) {
        _dayCount = [[UILabel alloc] init];
//        _dayCount.textColor = hexStringToColor(@"333333");
//        _dayCount.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _dayCount.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickDayBtn)];
        [_dayCount addGestureRecognizer:tap];
        _dayCount.userInteractionEnabled = YES;
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
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickDayBtn)];
        [_dayText addGestureRecognizer:tap];
        _dayText.userInteractionEnabled = YES;
    }
    return _dayText;
}


@end
