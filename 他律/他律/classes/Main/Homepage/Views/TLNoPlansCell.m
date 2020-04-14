//
//  TLNoPlansCell.m
//  他律
//
//  Created by sineboy on 2019/12/19.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNoPlansCell.h"

@interface TLNoPlansCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *imageV;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation TLNoPlansCell


+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLNoPlansCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLNoPlansCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}


-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.imageV];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.tipsLbl];
    [self.contentView addSubview:self.addBtn];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(15 * layoutBy6(), 0, J_SCREEN_WIDTH - 30 * layoutBy6(), 105 * layoutBy6());
    self.imageV.frame = CGRectMake(51.5 * layoutBy6(), 25.5 * layoutBy6(), 53.5 * layoutBy6(), 49.5 * layoutBy6());
    self.titleLbl.frame = CGRectMake(146 * layoutBy6(), 23.5 * layoutBy6(), J_SCREEN_WIDTH - 146 * layoutBy6() - 24 * layoutBy6(), 12.5 * layoutBy6());
    self.tipsLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 8.5 * layoutBy6(), self.titleLbl.width, 11 * layoutBy6());
    self.addBtn.frame = CGRectMake(self.titleLbl.left, self.tipsLbl.bottom + 8 * layoutBy6(), self.titleLbl.width, 24 * layoutBy6());
}

-(void)didClickAddBtn:(UIButton *)btn {
    if (self.addBtnCallBack) {
        self.addBtnCallBack(@(1));
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
        _imageV.image = [UIImage imageNamed:@"shouye_logo"];
    }
    return _imageV;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.text = @"目前暂无计划";
        _titleLbl.textColor = hexStringToColor(@"666666");
        _titleLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"别让明天的自己后悔";
        _tipsLbl.textColor = hexStringToColor(@"999999");
        _tipsLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLbl;
}

-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        _addBtn.layer.cornerRadius = 10 * layoutBy6();
        _addBtn.layer.masksToBounds = YES;
        _addBtn.backgroundColor = hexStringToColor(@"26c239");
        [_addBtn setTitle:@"+添加计划，每天五分钟，成为更好的自己" forState:UIControlStateNormal];
        [_addBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:10 * layoutBy6()];
        [_addBtn addTarget:self action:@selector(didClickAddBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
