//
//  TLNoNotionficationCell.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNoNotionficationCell.h"

@interface TLNoNotionficationCell ()

@property (nonatomic, strong) UILabel *titleLbl;

@end

@implementation TLNoNotionficationCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLNoNotionficationCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLNoNotionficationCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleLbl.text = title;
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"ffffff");
    [self.contentView addSubview:self.titleLbl];
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.titleLbl.frame = CGRectMake(20 * layoutBy6(), 160 * layoutBy6(), J_SCREEN_WIDTH - 40 * layoutBy6(), 14 * layoutBy6());
    
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"999999");
        _titleLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLbl;
}



@end
