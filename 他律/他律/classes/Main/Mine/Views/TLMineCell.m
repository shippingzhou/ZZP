//
//  TLMineCell.m
//  他律
//
//  Created by sineboy on 2019/12/25.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMineCell.h"

@interface TLMineCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UIImageView *rightView;

@property (nonatomic, strong) UILabel *focusMeText;

@property (nonatomic, strong) UILabel *focusedText;

@end

@implementation TLMineCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLMineCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLMineModel *)model {
    _model = model;
    self.imageV.image = [UIImage imageNamed:model.icon];
    self.titleLbl.text = model.title;
    self.focusMeText.text = [NSString stringWithFormat:@"%@人关注我",model.num1];
    self.focusedText.text = [NSString stringWithFormat:@"已关注%@人",model.num2];
    if ([model.isShow isEqualToString:@"1"]) {
        self.focusMeText.hidden = NO;
        self.focusedText.hidden = NO;
        self.rightView.hidden = YES;
    }else {
        self.focusMeText.hidden = YES;
        self.focusedText.hidden = YES;
        self.rightView.hidden = NO;
    }
}

-(void)setupUI {
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.rightView];
    [self.contentView addSubview:self.focusMeText];
    [self.contentView addSubview:self.focusedText];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0 * layoutBy6(), J_SCREEN_WIDTH, 50 * layoutBy6());
    self.imageV.frame = CGRectMake(15 * layoutBy6(), 17.5 * layoutBy6(), 16.5 * layoutBy6(), 16.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(self.imageV.right + 9 * layoutBy6(), self.imageV.top, 250 * layoutBy6(), 16.5 * layoutBy6());
    self.rightView.frame = CGRectMake(J_SCREEN_WIDTH - 16 * layoutBy6() - 7.8 * layoutBy6(), 18 * layoutBy6(), 7.8 * layoutBy6(), 14 * layoutBy6());
    self.focusMeText.frame = CGRectMake(J_SCREEN_WIDTH - 16 * layoutBy6() - 150 * layoutBy6(), 13.5 * layoutBy6(), 150 * layoutBy6(), 13.5 * layoutBy6());
    self.focusedText.frame = CGRectMake(J_SCREEN_WIDTH - 16 * layoutBy6() - 150 * layoutBy6(), self.focusMeText.bottom + 3.5 * layoutBy6(), 150 * layoutBy6(), 9.5 * layoutBy6());
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}


-(UIImageView *)imageV {
    if (!_imageV) {
        _imageV = [[UIImageView alloc] init];
    }
    return _imageV;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:16 * layoutBy6()];
    }
    return _titleLbl;
}

-(UIImageView *)rightView {
    if (!_rightView) {
        _rightView = [[UIImageView alloc] init];
        _rightView.image = [UIImage imageNamed:@"icon-xyb"];
    }
    return _rightView;
}

-(UILabel *)focusMeText {
    if (!_focusMeText) {
        _focusMeText = [[UILabel alloc] init];
        _focusMeText.textColor = hexStringToColor(@"333333");
        _focusMeText.font = [UIFont systemFontOfSize:16 * layoutBy6()];
        _focusMeText.textAlignment = NSTextAlignmentRight;
    }
    return _focusMeText;
}

-(UILabel *)focusedText {
    if (!_focusedText) {
        _focusedText = [[UILabel alloc] init];
        _focusedText.textColor = hexStringToColor(@"999999");
        _focusedText.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        _focusedText.textAlignment = NSTextAlignmentRight;
    }
    return _focusedText;
}

@end
