//
//  TLSystemNotificationCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSystemNotificationCell.h"

@interface TLSystemNotificationCell ()

@property (nonatomic, strong) UIImageView *authorView;

@property (nonatomic, strong) UILabel *authorLbl;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *dateLbl;

@property (nonatomic, strong) UILabel *systemContentLbl;

@property (nonatomic, strong) UILabel *chakanLbl;

@property (nonatomic, strong) UILabel *dianzanLbl;

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *contentLbl;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, assign) CGFloat authorLblWidth;

@end

@implementation TLSystemNotificationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLSystemNotificationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLSystemNotificationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLSystemModel *)model {
    _model = model;
    self.authorLblWidth = [[Untils defaultUntils] widthForString:@"他律官方" fontSize:13 * layoutBy6() andWidth:200 * layoutBy6() andHeight:20 * layoutBy6() isBoldMT:NO];
    self.dateLbl.text = model.date;
    self.contentLbl.text = model.content;
    self.systemContentLbl.text = model.systemContent;
    self.dianzanLbl.text = @"赞了你的评论";
    self.iconView.image = [UIImage imageNamed:@"icon_guanfang"];
    if ([model.type isEqualToString:@"点赞"]) {
        self.systemContentLbl.hidden = YES;
        self.contentLbl.hidden = NO;
        self.dianzanLbl.hidden = NO;
        self.chakanLbl.hidden = YES;
        self.bgView.hidden = NO;
    }else {
        self.systemContentLbl.hidden = NO;
        self.contentLbl.hidden = YES;
        self.dianzanLbl.hidden = YES;
        self.chakanLbl.hidden = NO;
        self.bgView.hidden  = YES;
    }
    CGFloat height = [[Untils defaultUntils] heightForString:model.systemContent fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 40 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO];
    
    if (height > 48 * layoutBy6()) {
        if (model.isOpen) {
            self.chakanLbl.hidden = YES;
        }else {
            self.chakanLbl.hidden = NO;
        }
    }else {
        self.chakanLbl.hidden = YES;
    }
    
}

-(void)setupUI {
    [self.contentView addSubview:self.authorView];
    [self.contentView addSubview:self.authorLbl];
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.systemContentLbl];
    [self.contentView addSubview:self.chakanLbl];
    [self.contentView addSubview:self.dianzanLbl];
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.contentLbl];
    [self.contentView addSubview:self.line];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.authorView.frame = CGRectMake(25 * layoutBy6(), 12 * layoutBy6(), 30 * layoutBy6(), 30 * layoutBy6());
    self.authorLbl.frame = CGRectMake(self.authorView.right + 10 * layoutBy6(), self.authorView.top, self.authorLblWidth, 12.5 * layoutBy6());
    self.iconView.frame = CGRectMake(self.authorLbl.right + 2.5 * layoutBy6(), self.authorLbl.top - 0.25 * layoutBy6(), 13 * layoutBy6(), 13 * layoutBy6());
    self.dateLbl.frame = CGRectMake(self.authorLbl.left, self.authorLbl.bottom + 7.5 * layoutBy6(), 200 * layoutBy6(), 11 * layoutBy6());
    self.systemContentLbl.frame = CGRectMake(25 * layoutBy6(), self.authorView.bottom + 15 * layoutBy6(), J_SCREEN_WIDTH - 40 * layoutBy6(), self.model.systemContentHeight);
    self.chakanLbl.frame = CGRectMake(self.systemContentLbl.right - 65 * layoutBy6(), self.systemContentLbl.bottom  - 15 * layoutBy6(), 56 * layoutBy6(), 15 * layoutBy6());
    self.dianzanLbl.frame = CGRectMake(25 * layoutBy6(), self.authorView.bottom + 15 * layoutBy6(), 250 * layoutBy6(), 12.5 * layoutBy6());
    self.bgView.frame = CGRectMake(25 * layoutBy6(), self.dianzanLbl.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 48 * layoutBy6(), self.model.contentHeight + 20 * layoutBy6());
    self.contentLbl.frame = CGRectMake(self.bgView.left + 10 * layoutBy6(), self.bgView.top + 10 * layoutBy6(), self.bgView.width - 20 * layoutBy6(), self.model.contentHeight);
    if ([self.model.type isEqualToString:@"点赞"]) {
        self.line.frame = CGRectMake(15 * layoutBy6(), self.bgView.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 0.5 * layoutBy6());
    }else {
        self.line.frame = CGRectMake(15 * layoutBy6(), self.systemContentLbl.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 0.5 * layoutBy6());
    }
}

-(void)didClickChakanBtn {
    if (self.chakanCallback) {
        self.chakanCallback(@(1));
    }
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
        _authorLbl.text = @"他律官方";
        _authorLbl.textColor = hexStringToColor(@"26c239");
        _authorLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _authorLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _authorLbl;
}

-(UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
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
        _bgView.backgroundColor = hexStringToColor(@"f5f7fb");
    }
    return _bgView;
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

-(UILabel *)systemContentLbl {
    if (!_systemContentLbl) {
        _systemContentLbl = [[UILabel alloc] init];
        _systemContentLbl.textColor = hexStringToColor(@"333333");
        _systemContentLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _systemContentLbl.textAlignment = NSTextAlignmentLeft;
        _systemContentLbl.numberOfLines = 0;
    }
    return _systemContentLbl;
}

-(UILabel *)chakanLbl {
    if (!_chakanLbl) {
        _chakanLbl = [[UILabel alloc] init];
        _chakanLbl.backgroundColor = hexStringToColor(@"ffffff");
        _chakanLbl.text = @"查看全部";
        _chakanLbl.textColor = hexStringToColor(@"26c239");
        _chakanLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _chakanLbl.textAlignment = NSTextAlignmentCenter;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickChakanBtn)];
        [_chakanLbl addGestureRecognizer:tap];
        _chakanLbl.userInteractionEnabled = YES;
    }
    return _chakanLbl;
}


-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = hexStringToColor(@"e9e9e9");
    }
    return _line;
}

@end
