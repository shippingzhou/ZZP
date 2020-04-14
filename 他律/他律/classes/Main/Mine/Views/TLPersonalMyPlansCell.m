//
//  TLPersonalMyPlansCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLPersonalMyPlansCell.h"
#import "UIImage+Utility.h"

@interface TLPersonalMyPlansCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIButton *iconBtn;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIView *coverView;

@property (nonatomic, strong) UIView *jinduView;

@property (nonatomic, strong) UILabel *wanchengduLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, assign) CGFloat iconWidth;

@property (nonatomic, assign) CGFloat jinduWidth;

@end

@implementation TLPersonalMyPlansCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLPersonalMyPlansCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLPersonalMyPlansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLPlansModel *)model {
    _model = model;
    
    if ([self.model.status isEqualToString:@"圆满完成"]) {
        self.iconBtn.hidden = NO;
        [self.iconBtn setBackgroundImage:[UIImage imageNamed:@"icon-yiwccc"] forState:UIControlStateNormal];
        [self.iconBtn setTitle:@"    圆满完成" forState:UIControlStateNormal];
        self.iconWidth = 88 * layoutBy6();
        self.jinduWidth = 276 * layoutBy6();
        
        UIColor *topleftColor = hexStringToColor(@"d6ff18");
        UIColor *bottomrightColor = hexStringToColor(@"26c239");
        CGSize size = CGSizeMake(self.jinduWidth, 10.5 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [self.jinduView setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        
        self.tipsLbl.text = [NSString stringWithFormat:@"已坚持%@天，实际用时%@天",model.nowDay, model.allDay];
    }else if ([self.model.status isEqualToString:@"完成"]) {
        self.iconBtn.hidden = NO;
        [self.iconBtn setBackgroundImage:[UIImage imageNamed:@"icon-wwwccc"] forState:UIControlStateNormal];
        [self.iconBtn setTitle:@"完成" forState:UIControlStateNormal];
        self.iconWidth = 70.5 * layoutBy6();
        self.jinduWidth = 276 * layoutBy6();
        
        UIColor *topleftColor = hexStringToColor(@"d6ff18");
        UIColor *bottomrightColor = hexStringToColor(@"26c239");
        CGSize size = CGSizeMake(self.jinduWidth, 10.5 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [self.jinduView setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        
        self.tipsLbl.text = [NSString stringWithFormat:@"已坚持%@天，剩余%@天",model.nowDay, model.allDay];
    }else {
        self.iconBtn.hidden = YES;
        self.jinduWidth = 276 * ([model.rate floatValue]/100) * layoutBy6();
        
        UIColor *topleftColor = hexStringToColor(@"fcff18");
        UIColor *bottomrightColor = hexStringToColor(@"e9941b");
        CGSize size = CGSizeMake(self.jinduWidth, 10.5 * layoutBy6());
        UIImage *bgImg = [UIImage gradientColorImageFromColors:@[topleftColor, bottomrightColor] gradientType:GradientTypeUpleftToLowright imgSize:size];
        [self.jinduView setBackgroundColor:[UIColor colorWithPatternImage:bgImg]];
        
        self.tipsLbl.text = [NSString stringWithFormat:@"已坚持%@天，剩余%@天",model.nowDay, model.lastDay];
    }
    self.titleLbl.text = model.title;
    self.wanchengduLbl.text = [NSString stringWithFormat:@"%@%@",model.rate, @"%"];
    
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.iconBtn];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.coverView];
    [self.contentView addSubview:self.jinduView];
    [self.contentView addSubview:self.wanchengduLbl];
    [self.contentView addSubview:self.tipsLbl];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(15 * layoutBy6(), 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 95 * layoutBy6());
    self.iconBtn.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - self.iconWidth, self.bgView.top, self.iconWidth, 21 * layoutBy6());
    self.titleLbl.frame = CGRectMake(self.bgView.left + 24.5 * layoutBy6(), self.bgView.top + 14.5 * layoutBy6(), 300 * layoutBy6(), 14.5 * layoutBy6());
    self.coverView.frame = CGRectMake(self.bgView.left + 15 * layoutBy6(), self.bgView.top + 48.5 * layoutBy6(), 276 * layoutBy6(), 10.5 * layoutBy6());
    self.jinduView.frame = CGRectMake(self.coverView.left, self.coverView.top, self.jinduWidth, 10.5 * layoutBy6());
    self.wanchengduLbl.frame = CGRectMake(self.coverView.right + 12 * layoutBy6(), self.coverView.top + 1 * layoutBy6(), 60 * layoutBy6(), 8.5 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(self.coverView.left, self.coverView.bottom + 10.5 * layoutBy6(), 250 * layoutBy6(), 11 * layoutBy6());
    
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIButton *)iconBtn {
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc] init];
        [_iconBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _iconBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    }
    return _iconBtn;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:15 * layoutBy6()];
    }
    return _titleLbl;
}

-(UIView *)coverView{
    if (!_coverView) {
        _coverView = [[UIView alloc] init];
        _coverView.layer.cornerRadius = 10.5/2 * layoutBy6();
        _coverView.layer.masksToBounds = YES;
        _coverView.backgroundColor = hexStringToColor(@"f0f0f0");
    }
    return _coverView;
}

-(UIView *)jinduView {
    if (!_jinduView) {
        _jinduView = [[UIView alloc] init];
        _jinduView.layer.cornerRadius = 10.5/2 * layoutBy6();
        _jinduView.layer.masksToBounds = YES;
    }
    return _jinduView;
}

-(UILabel *)wanchengduLbl {
    if (!_wanchengduLbl) {
        _wanchengduLbl = [[UILabel alloc] init];
        _wanchengduLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    }
    return _wanchengduLbl;
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.textColor = hexStringToColor(@"999999");
        _tipsLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    }
    return _tipsLbl;
}

@end
