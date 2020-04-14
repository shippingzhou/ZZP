//
//  TLMyPlansCell.m
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLMyPlansCell.h"

@interface TLMyPlansCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *fabuBtn;

@end

@implementation TLMyPlansCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLMyPlansCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLMyPlansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLMyPlanModel *)model {
    _model = model;
    self.titleLbl.text = model.title;
    self.tipsLbl.text = model.tips;
    self.tipsLbl.textColor = hexStringToColor(@"ff7451");
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.tipsLbl];
    [self.contentView addSubview:self.fabuBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(15 * layoutBy6(), 0, J_SCREEN_WIDTH - 30 * layoutBy6(), 65 * layoutBy6());
    self.titleLbl.frame = CGRectMake(26 * layoutBy6(), 14.5 * layoutBy6(), 250 * layoutBy6(), 14 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 10 * layoutBy6(), self.titleLbl.width, 11 * layoutBy6());
    self.fabuBtn.frame = CGRectMake(J_SCREEN_WIDTH - 24.5 * layoutBy6() - 75 * layoutBy6(), 20 * layoutBy6(), 75 * layoutBy6(), 25 * layoutBy6());
}

-(void)didClickfabuBtn:(UIButton *)btn {
    if (self.fabuBtnCallBack) {
        self.fabuBtnCallBack(@(1));
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
        _tipsLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentLeft;
    }
    return _tipsLbl;
}

-(UIButton *)fabuBtn {
    if (!_fabuBtn) {
        _fabuBtn = [[UIButton alloc] init];
        _fabuBtn.layer.cornerRadius = 10 * layoutBy6();
        _fabuBtn.layer.masksToBounds = YES;
        _fabuBtn.backgroundColor = hexStringToColor(@"26c239");
        [_fabuBtn setTitle:@"发布今日表现" forState:UIControlStateNormal];
        [_fabuBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _fabuBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        [_fabuBtn addTarget:self action:@selector(didClickfabuBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fabuBtn;
}

@end
