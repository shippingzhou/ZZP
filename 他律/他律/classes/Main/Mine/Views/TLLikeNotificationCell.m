//
//  TLLikeNotificationCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLikeNotificationCell.h"

@interface TLLikeNotificationCell ()

@property (nonatomic, strong) UIImageView *authorView;

@property (nonatomic, strong) UILabel *authorLbl;

@property (nonatomic, strong) UIImageView *iconView1;

@property (nonatomic, strong) UIImageView *iconView2;

@property (nonatomic, strong) UIButton *iconView3;

@property (nonatomic, strong) UILabel *dateLbl;

@property (nonatomic, strong) UILabel *dianzanLbl;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *contentLbl;

@property (nonatomic, strong) UIView *line;

@end

@implementation TLLikeNotificationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLLikeNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLLikeNotificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLNotificationModel *)model {
    _model = model;
    self.authorLbl.text = model.authorName;
    self.dateLbl.text = model.date;
    self.titleLbl.text = model.title;
    self.contentLbl.text = model.content;
    self.iconView1.image = [UIImage imageNamed:@"icon_pm_1"];
    self.iconView2.image = [UIImage imageNamed:@"icon_vip"];
    [self.iconView3 setBackgroundImage:[UIImage imageNamed:@"icon_qz"] forState:UIControlStateNormal];
    [self.iconView3 setTitle:@"求知者" forState:UIControlStateNormal];
    self.dianzanLbl.text = [NSString stringWithFormat:@"赞了你的%@",model.type];
}

-(void)setupUI {
    [self.contentView addSubview:self.authorView];
    [self.contentView addSubview:self.authorLbl];
    [self.contentView addSubview:self.iconView1];
    [self.contentView addSubview:self.iconView2];
    [self.contentView addSubview:self.iconView3];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.dianzanLbl];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.contentLbl];
    [self.contentView addSubview:self.line];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.authorView.frame = CGRectMake(25 * layoutBy6(), 12 * layoutBy6(), 30 * layoutBy6(), 30 * layoutBy6());
    self.authorLbl.frame = CGRectMake(self.authorView.right + 10.5 * layoutBy6(), self.authorView.top, self.model.authorLblWidth, 12.5 * layoutBy6());
    self.iconView1.frame = CGRectMake(self.authorLbl.right + 2.5 * layoutBy6(), self.authorLbl.top + 1.25 * layoutBy6(), 15 * layoutBy6(), 10 * layoutBy6());
    self.iconView2.frame = CGRectMake(self.iconView1.right + 0.5 * layoutBy6(), self.iconView1.top - 0.5 * layoutBy6(), 13.5 * layoutBy6(), 11 * layoutBy6());
    self.iconView3.frame = CGRectMake(self.iconView2.right + 1 * layoutBy6(), self.iconView2.top, 30 * layoutBy6(), 11 * layoutBy6());
    self.dateLbl.frame = CGRectMake(self.authorLbl.left, self.authorLbl.bottom + 7.5 * layoutBy6(), 200 * layoutBy6(), 11 * layoutBy6());
    self.dianzanLbl.frame = CGRectMake(self.authorView.left, self.authorView.bottom + 15 * layoutBy6(), 200 * layoutBy6(), 12.5 * layoutBy6());
    
    if ([self.model.title isEqualToString:@""]) {
        self.bgView.frame = CGRectMake(self.dianzanLbl.left, self.dianzanLbl.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 48 * layoutBy6(), self.model.contentHeight + 20 * layoutBy6());
        
        self.contentLbl.frame = CGRectMake(self.bgView.left + 10 * layoutBy6(), self.bgView.top + 10 * layoutBy6(), self.bgView.width - 20 * layoutBy6(), self.model.contentHeight);
    }else {
        self.bgView.frame = CGRectMake(self.dianzanLbl.left, self.dianzanLbl.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 48 * layoutBy6(), self.model.contentHeight + 44 * layoutBy6());
        self.titleLbl.frame = CGRectMake(self.bgView.left + 10 * layoutBy6(), self.bgView.top + 10 * layoutBy6(), self.bgView.width - 20 * layoutBy6(), 12.5 * layoutBy6());
        self.contentLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 10 * layoutBy6(), self.bgView.width - 20 * layoutBy6(), self.model.contentHeight);
    }
    self.line.frame = CGRectMake(15 * layoutBy6(), self.bgView.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 0.5 * layoutBy6());
    
}

-(UIImageView *)authorView {
    if (!_authorView) {
        _authorView = [[UIImageView alloc] init];
        _authorView.layer.cornerRadius = 15 * layoutBy6();
        _authorView.layer.masksToBounds = YES;
        _authorView.image = [UIImage imageNamed:@"shouye_logo"];
    }
    return _authorView;
}

-(UILabel *)authorLbl {
    if (!_authorLbl) {
        _authorLbl = [[UILabel alloc] init];
        _authorLbl.textColor = hexStringToColor(@"333333");
        _authorLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _authorLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _authorLbl;
}

-(UIImageView *)iconView1 {
    if (!_iconView1) {
        _iconView1 = [[UIImageView alloc] init];
    }
    return _iconView1;
}

-(UIImageView *)iconView2 {
    if (!_iconView2) {
        _iconView2 = [[UIImageView alloc] init];
    }
    return _iconView2;
}

-(UIButton *)iconView3 {
    if (!_iconView3) {
        _iconView3 = [[UIButton alloc] init];
        [_iconView3 setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _iconView3.titleLabel.font = [UIFont systemFontOfSize:8 * layoutBy6()];
    }
    return _iconView3;
}

-(UILabel *)dateLbl {
    if (!_dateLbl) {
        _dateLbl = [[UILabel alloc] init];
        _dateLbl.textColor = hexStringToColor(@"999999");
        _dateLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    }
    return _dateLbl;
}

-(UILabel *)dianzanLbl {
    if (!_dianzanLbl) {
        _dianzanLbl = [[UILabel alloc] init];
        _dianzanLbl.textColor = hexStringToColor(@"333333");
        _dianzanLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
    }
    return _dianzanLbl;
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 5 * layoutBy6();
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = hexStringToColor(@"f5f7fb");
    }
    return _bgView;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLbl;
}

-(UILabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textColor = hexStringToColor(@"999999");
        _contentLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _contentLbl.textAlignment = NSTextAlignmentLeft;
//        _contentLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLbl.numberOfLines = 3;
    }
    return _contentLbl;
}


-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = hexStringToColor(@"e9e9e9");
    }
    return _line;
}

@end
