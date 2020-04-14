//
//  TLFirstLoginView.m
//  他律
//
//  Created by sineboy on 2020/3/27.
//  Copyright © 2020 com. All rights reserved.
//

#import "TLFirstLoginView.h"
#import "UIImage+Extension.h"

@interface TLFirstLoginView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *lbl1; //

@property (nonatomic, strong) UILabel *lbl2; //

@property (nonatomic, strong) UILabel *content1; //

@property (nonatomic, strong) UILabel *lbl3; //

@property (nonatomic, strong) UILabel *content2; //

@property (nonatomic, strong) UILabel *lbl4; //

@property (nonatomic, strong) UIButton *btn; //


@end

@implementation TLFirstLoginView

-(instancetype)init {
    self = [super init];
    if (self) {
        [self creatView];
    }
    return self;
}

-(void)creatView {
    [self addSubview:self.coverView];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.titleLbl];
    [self.bgView addSubview:self.lbl1];
    [self.bgView addSubview:self.lbl2];
    [self.bgView addSubview:self.content1];
    [self.bgView addSubview:self.lbl3];
    [self.bgView addSubview:self.content2];
    [self.bgView addSubview:self.lbl4];
    [self.bgView addSubview:self.btn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.coverView.frame = self.bounds;
    self.bgView.frame = CGRectMake(0, 231.5 * layoutBy6(), J_SCREEN_WIDTH, J_SCREEN_HEIGHT - 231.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(15 * layoutBy6(), 28 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 20 * layoutBy6());
    self.lbl1.frame = CGRectMake(25 * layoutBy6(), self.titleLbl.bottom + 25 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 10 * layoutBy6());
    self.lbl2.frame = CGRectMake(25 * layoutBy6(), self.lbl1.bottom + 20 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 10 * layoutBy6());
    CGFloat height1 = [[Untils defaultUntils] heightForString:self.content1.text fontSize:12 * layoutBy6() andWidth:J_SCREEN_WIDTH - 50 * layoutBy6() andHeight:150 * layoutBy6() isBoldMT:NO] + 2 * 8 * layoutBy6();
    self.content1.frame = CGRectMake(25 * layoutBy6(), self.lbl2.bottom + 8 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), height1);
    self.lbl3.frame = CGRectMake(25 * layoutBy6(), self.content1.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 10 * layoutBy6());
    CGFloat height2 = [[Untils defaultUntils] heightForString:self.content2.text fontSize:12 * layoutBy6() andWidth:J_SCREEN_WIDTH - 50 * layoutBy6() andHeight:200 * layoutBy6() isBoldMT:NO] + 5 * 8 * layoutBy6();
    self.content2.frame = CGRectMake(25 * layoutBy6(), self.lbl3.bottom + 8 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), height2);
    self.lbl4.frame = CGRectMake(25 * layoutBy6(), self.content2.bottom + 8 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 10 * layoutBy6());
    self.btn.frame = CGRectMake(25 * layoutBy6(), self.bgView.height - 7.5 * layoutBy6() - 50 * layoutBy6(), J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
}

-(void)didClickNextBtn {
    if (self.nextBtnCallback) {
        self.nextBtnCallback(@(1));
    }
}

-(UIView *)coverView {
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = hexStringToColor(@"000000");
        _coverView.alpha = 0.5;
    }
    return _coverView;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"致律友";
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:21 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

-(UILabel *)lbl1 {
    if (!_lbl1) {
        _lbl1 = [[UILabel alloc] init];
        _lbl1.text = @"他律致力成为全球“最正能量”的自我改变社区";
        _lbl1.textColor = hexStringToColor(@"333333");
        _lbl1.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _lbl1.textAlignment = NSTextAlignmentLeft;
    }
    return _lbl1;
}

-(UILabel *)lbl2 {
    if (!_lbl2) {
        _lbl2 = [[UILabel alloc] init];
        _lbl2.text = @"在他律，您将遇到三类人：";
        _lbl2.textColor = hexStringToColor(@"999999");
        _lbl2.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _lbl2.textAlignment = NSTextAlignmentLeft;
    }
    return _lbl2;
}

-(UILabel *)content1 {
    if (!_content1) {
        _content1 = [[UILabel alloc] init];
        _content1.text = @"1、成功改变自我的人 \n2、正在改变自我的人 \n3、渴望改变自我的人";
        _content1.textColor = hexStringToColor(@"666666");
        _content1.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _content1.textAlignment = NSTextAlignmentLeft;

        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

        paragraphStyle.lineSpacing = 8 * layoutBy6();

        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];

        _content1.attributedText = [[NSAttributedString alloc] initWithString:_content1.text attributes:attributes];
        _content1.numberOfLines = 0;
    }
    return _content1;
}

-(UILabel *)lbl3 {
    if (!_lbl3) {
        _lbl3 = [[UILabel alloc] init];
        _lbl3.text = @"通过他律，您可以：";
        _lbl3.textColor = hexStringToColor(@"999999");
        _lbl3.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _lbl3.textAlignment = NSTextAlignmentLeft;
    }
    return _lbl3;
}

-(UILabel *)content2 {
    if (!_content2) {
        _content2 = [[UILabel alloc] init];
        _content2.text = @"1、改变生活状态 \n2、提升工作效率 \n3、改善人际关系 \n4、培养自律能力 \n... \n为此，您需要付出：";
        _content2.textColor = hexStringToColor(@"666666");
        _content2.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _content2.textAlignment = NSTextAlignmentLeft;
        NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];

        paragraphStyle.lineSpacing = 8 * layoutBy6();

        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];

        [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];

        _content2.attributedText = [[NSAttributedString alloc] initWithString:_content2.text attributes:attributes];
        _content2.numberOfLines = 0;
    }
    return _content2;
}

-(UILabel *)lbl4 {
    if (!_lbl4) {
        _lbl4 = [[UILabel alloc] init];
        _lbl4.text = @"每天5分钟(至少坚持一个月)";
        _lbl4.textColor = hexStringToColor(@"333333");
        _lbl4.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _lbl4.textAlignment = NSTextAlignmentLeft;
    }
    return _lbl4;
}

-(UIButton *)btn {
    if (!_btn) {
        _btn = [[UIButton alloc] init];
        [_btn setTitle:@"立即体验，开启改变之门" forState:UIControlStateNormal];
        _btn.layer.cornerRadius = 5 * layoutBy6();
        _btn.layer.masksToBounds = YES;
        UIColor *topleftColor = hexStringToColor(@"7dd504");
        UIColor *bottomrightColor = hexStringToColor(@"16bc48");
        CGSize size = CGSizeMake(J_SCREEN_WIDTH - 50 * layoutBy6(), 50 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [_btn setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        _btn.titleLabel.font = [UIFont systemFontOfSize:18 * layoutBy6()];
        [_btn addTarget:self action:@selector(didClickNextBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}



@end
