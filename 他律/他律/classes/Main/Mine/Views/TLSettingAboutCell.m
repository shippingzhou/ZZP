//
//  TLSettingAboutCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSettingAboutCell.h"

@interface TLSettingAboutCell ()

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *subTitleLbl;

@property (nonatomic, strong) UIImageView *rightView;

@end

@implementation TLSettingAboutCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLSettingAboutCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLSettingAboutCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLSettingModel *)model {
    _model = model;
    self.titleLbl.text = model.title;
    self.subTitleLbl.text = model.subTitle;
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"ffffff");
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.subTitleLbl];
    [self.contentView addSubview:self.rightView];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    if ([self.model.subTitle isEqualToString:@""]) {
        self.titleLbl.frame = CGRectMake(15 * layoutBy6(), 21 * layoutBy6(), 250 * layoutBy6(), 14 * layoutBy6());
        self.rightView.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 8 * layoutBy6(), 21 * layoutBy6(), 8 * layoutBy6(), 14 * layoutBy6());
    }else {
        self.titleLbl.frame = CGRectMake(15 * layoutBy6(), 12.5 * layoutBy6(), 250 * layoutBy6(), 14 * layoutBy6());
        self.subTitleLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 7 * layoutBy6(), 250 * layoutBy6(), 11 * layoutBy6());
        self.rightView.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 8 * layoutBy6(), 20.5 * layoutBy6(), 8 * layoutBy6(), 14 * layoutBy6());
    }
    
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

-(UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"icon-xyb"];
    }
    return _rightView;
}

@end
