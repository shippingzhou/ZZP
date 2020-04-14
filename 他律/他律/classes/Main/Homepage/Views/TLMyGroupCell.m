//
//  TLMyGroupCell.m
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMyGroupCell.h"

@interface TLMyGroupCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *nameLbl;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *remindBtn;

@end

@implementation TLMyGroupCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLMyGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLMyGroupCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    self.tipsLbl.text = model.tips;
    if ([model.tips isEqualToString:@"预计13:00打卡，已坚持1天，完成度5%"]) {
        self.tipsLbl.textColor = hexStringToColor(@"999999");
    }else if ([model.tips isEqualToString:@"尚未记录今日表现，已坚持1天，完成度5%"]) {
        self.tipsLbl.textColor = hexStringToColor(@"ff7451");
    }else if ([model.tips isEqualToString:@"今日记录2次，已坚持2天，完成度10%"]) {
        self.tipsLbl.textColor = hexStringToColor(@"26c239");
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
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.nameLbl];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.tipsLbl];
    [self.contentView addSubview:self.remindBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if ([self.model.title isEqualToString:@"无执行中的计划"]) {
        self.bgView.frame = CGRectMake(15 * layoutBy6(), 0, J_SCREEN_WIDTH - 30 * layoutBy6(), 69 * layoutBy6());
    }else {
        self.bgView.frame = CGRectMake(15 * layoutBy6(), 0, J_SCREEN_WIDTH - 30 * layoutBy6(), 90 * layoutBy6());
    }
    self.imageV.frame = CGRectMake(25 * layoutBy6(), 15 * layoutBy6(), 30 * layoutBy6(), 30 * layoutBy6());
    self.nameLbl.frame = CGRectMake(64.5 * layoutBy6(), 15 * layoutBy6(), 220 * layoutBy6(), 11.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(self.nameLbl.left, self.nameLbl.bottom + 12.5 * layoutBy6(), 220 * layoutBy6(), 14 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 16.5 * layoutBy6(), self.titleLbl.width, 11 * layoutBy6());
    self.remindBtn.frame = CGRectMake(J_SCREEN_WIDTH - 25 * layoutBy6() - 75 * layoutBy6(), 15 * layoutBy6(), 75 * layoutBy6(), 25 * layoutBy6());
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
        _nameLbl.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _nameLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLbl;
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

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"别让明天的自己后悔";
        _tipsLbl.textColor = hexStringToColor(@"999999");
        _tipsLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLbl;
}

-(UIButton *)remindBtn {
    if (!_remindBtn) {
        _remindBtn = [[UIButton alloc] init];
        _remindBtn.layer.cornerRadius = 10 * layoutBy6();
        _remindBtn.layer.masksToBounds = YES;
        _remindBtn.layer.borderWidth = 1;
        _remindBtn.titleLabel.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        [_remindBtn addTarget:self action:@selector(didClickremindBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _remindBtn;
}

@end
