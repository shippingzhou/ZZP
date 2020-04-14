//
//  TLLvyouQuanWeiGuanzhuCell.m
//  他律
//
//  Created by sineboy on 2019/12/23.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLvyouQuanWeiGuanzhuCell.h"

@interface TLLvyouQuanWeiGuanzhuCell ()

@property (nonatomic, strong) UILabel *tipsLbl;

@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation TLLvyouQuanWeiGuanzhuCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLLvyouQuanWeiGuanzhuCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLLvyouQuanWeiGuanzhuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.tipsLbl];
    [self.contentView addSubview:self.addBtn];
}

-(void)didClickAddBtn {
    if (self.addGuanzhuCallback) {
        self.addGuanzhuCallback(@(1));
    }
}

-(void)layoutSubviews {
    [super layoutSubviews];
    CGFloat height = J_SCREEN_HEIGHT - 107 * layoutBy6() - J_TabBarHeight;
    self.tipsLbl.frame = CGRectMake(0, height/2 - 6 * layoutBy6() - 10.5 * layoutBy6(), J_SCREEN_WIDTH, 10.5 * layoutBy6());
    self.addBtn.frame = CGRectMake(J_SCREEN_WIDTH/2 - 205/2 * layoutBy6(), height/2 + 6 * layoutBy6(), 205 * layoutBy6(), 24 * layoutBy6());
}

-(UILabel *)tipsLbl {
    if (!_tipsLbl) {
        _tipsLbl = [[UILabel alloc] init];
        _tipsLbl.text = @"暂未关注任何人";
        _tipsLbl.textColor = hexStringToColor(@"999999");
        _tipsLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _tipsLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _tipsLbl;
}

-(UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] init];
        _addBtn.layer.cornerRadius = 12 * layoutBy6();
        _addBtn.layer.masksToBounds = YES;
        _addBtn.backgroundColor = hexStringToColor(@"26c239");
        [_addBtn setTitle:@"去社区逛逛，关注下其他律友吧" forState:UIControlStateNormal];
        [_addBtn setTitleColor:hexStringToColor(@"ffffff") forState:UIControlStateNormal];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        [_addBtn addTarget:self action:@selector(didClickAddBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

@end
