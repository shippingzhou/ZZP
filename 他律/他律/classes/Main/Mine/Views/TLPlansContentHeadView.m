//
//  TLPlansContentHeadView.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLPlansContentHeadView.h"

@interface TLPlansContentHeadView ()

@property (nonatomic, strong) UILabel *titleText;

@property (nonatomic, strong) UILabel *titleContent;

@property (nonatomic, strong) UILabel *timeText;

@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, strong) UILabel *timeContent;

@property (nonatomic, strong) UILabel *beixuanText;

@property (nonatomic, strong) UILabel *beixuanContent;

@property (nonatomic, strong) UILabel *chakanLbl;

@property (nonatomic, strong) UILabel *jinduText;

@property (nonatomic, strong) UILabel *jinduContent;

@end

@implementation TLPlansContentHeadView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)setModel:(TLPlansModel *)model {
    _model = model;
    self.titleContent.text = model.title;
    self.timeContent.text = model.lastTime;
    self.beixuanContent.text = model.beixuan;
    self.jinduContent.text = [NSString stringWithFormat:@"已坚持%@天，剩余%@天（完成度%@%@）",model.nowDay,model.lastDay, model.rate,@"%"];
}

-(void)creatView {
    self.backgroundColor = hexStringToColor(@"ffffff");
    [self addSubview:self.titleText];
    [self addSubview:self.titleContent];
    [self addSubview:self.timeText];
    [self addSubview:self.rightView];
    [self addSubview:self.timeContent];
    [self addSubview:self.beixuanText];
    [self addSubview:self.beixuanContent];
    [self addSubview:self.chakanLbl];
    [self addSubview:self.jinduText];
    [self addSubview:self.jinduContent];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.titleText.frame = CGRectMake(15.5 * layoutBy6(), 19.7 * layoutBy6(), 150 * layoutBy6(), 14 * layoutBy6());
    self.titleContent.frame = CGRectMake(J_SCREEN_WIDTH - 15.5 * layoutBy6() - 250 * layoutBy6(), self.titleText.top, 250 * layoutBy6(), 14 * layoutBy6());
    if ([self.model.status isEqualToString:@"未完成"]) {
        self.timeText.frame = CGRectMake(self.titleText.left, self.titleText.bottom + 26.5 * layoutBy6(), self.titleText.width, self.titleText.height);
        self.rightView.frame = CGRectMake(J_SCREEN_WIDTH - 14.5 * layoutBy6() - 8.5 * layoutBy6(), self.timeText.top - 0.5 * layoutBy6(), 8.5 * layoutBy6(), 15 * layoutBy6());
        self.timeContent.frame = CGRectMake(self.rightView.left - 8 * layoutBy6() - 100 * layoutBy6(), self.rightView.top, 100 * layoutBy6(), 15 * layoutBy6());
        
        self.beixuanText.frame = CGRectMake(self.titleText.left, self.timeText.bottom + 26.5 * layoutBy6(), self.titleText.width, self.titleText.height);
        self.beixuanContent.frame = CGRectMake(J_SCREEN_WIDTH - 15.5 * layoutBy6() - 250 * layoutBy6(), self.beixuanText.top, 250 * layoutBy6(), self.beixuanText.height);
    }else {
        self.beixuanText.frame = CGRectMake(self.titleText.left, self.titleText.bottom + 26.5 * layoutBy6(), self.titleText.width, self.titleText.height);
        self.beixuanContent.frame = CGRectMake(J_SCREEN_WIDTH - 15.5 * layoutBy6() - 250 * layoutBy6(), self.beixuanText.top, 250 * layoutBy6(), self.beixuanText.height);
    }
    self.chakanLbl.frame = CGRectMake(self.beixuanContent.right - 60 * layoutBy6(), self.beixuanContent.top, 60 * layoutBy6(), self.beixuanContent.height);
    self.jinduText.frame = CGRectMake(self.titleText.left, self.beixuanText.bottom + 26.5 * layoutBy6(), self.titleText.width, self.titleText.height);
    self.jinduContent.frame = CGRectMake(J_SCREEN_WIDTH - 15.5 * layoutBy6() - 250 * layoutBy6(), self.jinduText.top, 250 * layoutBy6(), self.jinduText.height);
}

-(void)didClickChakanQuanbu {
    if (self.chakanCallback) {
        self.chakanCallback(@(1));
    }
}

-(UILabel *)titleText {
    if (!_titleText) {
        _titleText = [[UILabel alloc] init];
        _titleText.text = @"计划名称";
        _titleText.textColor = hexStringToColor(@"666666");
        _titleText.font = [UIFont systemFontOfSize:14 * layoutBy6()];
    }
    return _titleText;
}

-(UILabel *)titleContent {
    if (!_titleContent) {
        _titleContent = [[UILabel alloc] init];
        _titleContent.textColor = hexStringToColor(@"333333");
        _titleContent.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _titleContent.textAlignment = NSTextAlignmentRight;
    }
    return _titleContent;
}

-(UILabel *)timeText {
    if (!_timeText) {
        _timeText = [[UILabel alloc] init];
        _timeText.text = @"最晚打卡时间";
        _timeText.textColor = hexStringToColor(@"666666");
        _timeText.font = [UIFont systemFontOfSize:14 * layoutBy6()];
    }
    return _timeText;
}

-(UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"icon-xyb"];
    }
    return _rightView;
}

-(UILabel *)timeContent {
    if (!_timeContent) {
        _timeContent = [[UILabel alloc] init];
        _timeContent.textColor = hexStringToColor(@"333333");
        _timeContent.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _timeContent.textAlignment = NSTextAlignmentRight;
    }
    return _timeContent;
}

-(UILabel *)beixuanText {
    if (!_beixuanText) {
        _beixuanText = [[UILabel alloc] init];
        _beixuanText.text = @"备选计划";
        _beixuanText.textColor = hexStringToColor(@"666666");
        _beixuanText.font = [UIFont systemFontOfSize:14 * layoutBy6()];
    }
    return _beixuanText;
}

-(UILabel *)beixuanContent {
    if (!_beixuanContent) {
        _beixuanContent = [[UILabel alloc] init];
        _beixuanContent.textColor = hexStringToColor(@"333333");
        _beixuanContent.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _beixuanContent.textAlignment = NSTextAlignmentRight;
    }
    return _beixuanContent;
}

-(UILabel *)chakanLbl {
    if (!_chakanLbl) {
        _chakanLbl = [[UILabel alloc] init];
        _chakanLbl.backgroundColor = hexStringToColor(@"ffffff");
        _chakanLbl.text = @"查看全部";
        _chakanLbl.textColor = hexStringToColor(@"26c239");
        _chakanLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _chakanLbl.textAlignment = NSTextAlignmentRight;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickChakanQuanbu)];
        [_chakanLbl addGestureRecognizer:tap];
        _chakanLbl.userInteractionEnabled = YES;
    }
    return _chakanLbl;
}

-(UILabel *)jinduText {
    if (!_jinduText) {
        _jinduText = [[UILabel alloc] init];
        _jinduText.text = @"计划进度";
        _jinduText.textColor = hexStringToColor(@"666666");
        _jinduText.font = [UIFont systemFontOfSize:14 * layoutBy6()];
    }
    return _jinduText;
}

-(UILabel *)jinduContent {
    if (!_jinduContent) {
        _jinduContent = [[UILabel alloc] init];
        _jinduContent.textColor = hexStringToColor(@"333333");
        _jinduContent.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _jinduContent.textAlignment = NSTextAlignmentRight;
    }
    return _jinduContent;
}

@end
