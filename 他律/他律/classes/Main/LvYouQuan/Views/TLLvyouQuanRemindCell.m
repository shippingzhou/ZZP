//
//  TLLvyouQuanRemindCell.m
//  他律
//
//  Created by sineboy on 2019/12/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLvyouQuanRemindCell.h"

@interface TLLvyouQuanRemindCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UIImageView *iconView1;

@property (nonatomic, strong) UIImageView *iconView2;

@property (nonatomic, strong) UIButton *iconView3;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIButton *remindBtn;

@end

@implementation TLLvyouQuanRemindCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLLvyouQuanRemindCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLLvyouQuanRemindCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLGroupModel *)model {
    _model = model;
    self.nameLbl.text = model.name;
    self.titleLbl.text = model.title;
    if ([model.title isEqualToString:@"无执行中的计划"]) {
        self.titleLbl.textColor = hexStringToColor(@"c2c2c2");
    }else {
        self.titleLbl.textColor = hexStringToColor(@"333333");
    }
    
    [self.remindBtn setTitle:model.buttonTitle forState:UIControlStateNormal];
    if ([model.buttonTitle isEqualToString:@"提醒打卡"]) {
        [self.remindBtn setTitleColor:hexStringToColor(@"ff7451") forState:UIControlStateNormal];
        self.remindBtn.layer.borderColor = hexStringToColor(@"ff7451").CGColor;
        self.remindBtn.userInteractionEnabled = YES;
    }else {
        [self.remindBtn setTitleColor:hexStringToColor(@"cdcdcd") forState:UIControlStateNormal];
        self.remindBtn.layer.borderColor = hexStringToColor(@"cdcdcd").CGColor;
        self.remindBtn.userInteractionEnabled = NO;
    }
    
    self.iconView1.image = [UIImage imageNamed:@"icon_pm_1"];
    self.iconView2.image = [UIImage imageNamed:@"icon_vip"];
    [self.iconView3 setBackgroundImage:[UIImage imageNamed:@"icon_qz"] forState:UIControlStateNormal];
    [self.iconView3 setTitle:@"求知者" forState:UIControlStateNormal];
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.iconView1];
    [self.contentView addSubview:self.iconView2];
    [self.contentView addSubview:self.iconView3];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.remindBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(15 * layoutBy6(), 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 69 * layoutBy6());
    self.imageV.frame = CGRectMake(25 * layoutBy6(), 25 * layoutBy6(), 30 * layoutBy6(), 30 * layoutBy6());
    CGFloat nameWidth = [[Untils defaultUntils] widthForString:self.model.name fontSize:13 * layoutBy6() andWidth:200 * layoutBy6() andHeight:15 * layoutBy6() isBoldMT:NO];
    self.nameLbl.frame = CGRectMake(self.imageV.right + 10.5 * layoutBy6(), self.imageV.top, nameWidth, 12.5 * layoutBy6());
    self.iconView1.frame = CGRectMake(self.nameLbl.right + 2.5 * layoutBy6(), self.nameLbl.top + 1.25 * layoutBy6(), 15 * layoutBy6(), 10 * layoutBy6());
    self.iconView2.frame = CGRectMake(self.iconView1.right + 0.5 * layoutBy6(), self.iconView1.top - 0.5 * layoutBy6(), 13.5 * layoutBy6(), 11 * layoutBy6());
    self.iconView3.frame = CGRectMake(self.iconView2.right + 1 * layoutBy6(), self.iconView2.top, 30 * layoutBy6(), 11 * layoutBy6());
    self.titleLbl.frame = CGRectMake(self.nameLbl.left, self.nameLbl.bottom + 11.5 * layoutBy6(), 220 * layoutBy6(), 14 * layoutBy6());
    self.remindBtn.frame = CGRectMake(J_SCREEN_WIDTH - 25 * layoutBy6() - 75 * layoutBy6(), 25 * layoutBy6(), 75 * layoutBy6(), 25 * layoutBy6());
}

-(void)didClickremindBtn:(UIButton *)btn {
    if (self.remindBtnCallBack) {
        self.remindBtnCallBack(@(1));
    }
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.layer.cornerRadius = 5;
        _bgView.layer.masksToBounds = YES;
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
        _imageV.layer.cornerRadius = 15 * layoutBy6();
        _imageV.layer.masksToBounds = YES;
        _imageV.image = [UIImage imageNamed:@"shouye_logo"];
    }
    return _imageV;
}

-(UILabel *)nameLbl {
    if (!_nameLbl) {
        _nameLbl = [[UILabel alloc] init];
        _nameLbl.textColor = hexStringToColor(@"666666");
        _nameLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLbl;
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

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLbl;
}

-(UIButton *)remindBtn {
    if (!_remindBtn) {
        _remindBtn = [[UIButton alloc] init];
        _remindBtn.layer.cornerRadius = 10 * layoutBy6();
        _remindBtn.layer.masksToBounds = YES;
        _remindBtn.layer.borderWidth = 1;
        _remindBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        [_remindBtn addTarget:self action:@selector(didClickremindBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remindBtn;
}

@end
