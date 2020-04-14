//
//  TLSettingCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSettingCell.h"

@interface TLSettingCell ()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *subTitleLbl;

@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation TLSettingCell


+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLSettingCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLSettingModel *)model {
    _model = model;
    self.titleLbl.text = model.title;
    self.subTitleLbl.text = model.subTitle;
    if ([model.isOn isEqualToString:@"on"]) {
        [self.switchBtn setOn:YES];
    }else {
        [self.switchBtn setOn:NO];
    }
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"ffffff");
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.subTitleLbl];
    [self.contentView addSubview:self.switchBtn];
}

-(void)didClickSwitchBtn:(UISwitch *)sender {
    if (self.switchBtnCallback) {
        self.switchBtnCallback(sender);
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.titleLbl.frame = CGRectMake(15.5 * layoutBy6(), 12.5 * layoutBy6(), 250 * layoutBy6(), 14 * layoutBy6());
    self.subTitleLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 7 * layoutBy6(), 250 * layoutBy6(), 11.5 * layoutBy6());
    self.switchBtn.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 40 * layoutBy6(), 13.5 * layoutBy6(), 40 * layoutBy6(), 24 * layoutBy6());
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

-(UILabel *)subTitleLbl {
    if (!_subTitleLbl) {
        _subTitleLbl = [[UILabel alloc] init];
        _subTitleLbl.textColor = hexStringToColor(@"999999");
        _subTitleLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _subTitleLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _subTitleLbl;
}

-(UISwitch *)switchBtn {
    if (!_switchBtn) {
        _switchBtn = [[UISwitch alloc] init];
        [_switchBtn setOnImage:[UIImage imageNamed:@"icon_kaiguan"]];
        [_switchBtn setOffImage:[UIImage imageNamed:@"icon_kaiguan_g"]];
        [_switchBtn addTarget:self action:@selector(didClickSwitchBtn:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

@end
