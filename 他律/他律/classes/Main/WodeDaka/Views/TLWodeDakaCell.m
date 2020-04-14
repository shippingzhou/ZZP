//
//  TLWodeDakaCell.m
//  他律
//
//  Created by sineboy on 2019/12/24.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLWodeDakaCell.h"
#import "CustomButton.h"
#import "KNPhotoBrower.h"

@interface TLWodeDakaCell ()

@property (nonatomic, strong) UIView *bgView;

@property (nonatomic, strong) UIImageView *authorView;

@property (nonatomic, strong) UILabel *authorLbl;

@property (nonatomic, strong) UIImageView *iconView1;

@property (nonatomic, strong) UIImageView *iconView2;

@property (nonatomic, strong) UIButton *iconView3;

@property (nonatomic, strong) UILabel *dateLbl;

@property (nonatomic, strong) UILabel *leijiLbl;

@property (nonatomic, strong) UILabel *shenheNeirongLbl;

@property (nonatomic, strong) UILabel *titleLbl;

@property (nonatomic, strong) UILabel *contentLbl;

@property (nonatomic, strong) UIView *picView;

@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, assign) CGFloat titleHeight;

@property (nonatomic, strong) CustomButton *readBtn;

@property (nonatomic, strong) CustomButton *commentBtn;

@property (nonatomic, strong) CustomButton *collectBtn;

@property (nonatomic, strong) CustomButton *forwardBtn;

@property (nonatomic, strong) UIView *shenpingBgView;

@property (nonatomic, strong) UILabel *shenpingLbl;

@property (nonatomic, strong) NSArray *picArr;

@property (nonatomic, strong) NSMutableArray *itemsArr;

@end

@implementation TLWodeDakaCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifer:(NSString *)identifier
{
    TLWodeDakaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[TLWodeDakaCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        [cell setupUI];
    }
    return cell;
}

-(void)setModel:(TLLvyouQuanModel *)model {
    _model = model;
    self.authorLbl.text = model.authorName;
    self.iconView1.image = [UIImage imageNamed:@"icon_pm_1"];
    self.iconView2.image = [UIImage imageNamed:@"icon_vip"];
    [self.iconView3 setBackgroundImage:[UIImage imageNamed:@"icon_qz"] forState:UIControlStateNormal];
    [self.iconView3 setTitle:@"求知者" forState:UIControlStateNormal];
    self.dateLbl.text = model.date;
    self.leijiLbl.text = [NSString stringWithFormat:@"累计打卡%@天",model.days];
    self.titleLbl.text = model.title;
    
    self.contentLbl.text = model.content;
    NSString *imgStr = model.imgs;
    
    self.picArr = [model.imgs componentsSeparatedByString:@","];
    [self setupPicView];
    self.readBtn.customTitle.text = model.readCount;
    self.commentBtn.customTitle.text = model.commentCount;
    self.collectBtn.customTitle.text = model.collectCount;
    self.forwardBtn.customTitle.text = model.forwardCount;
    if ([model.isRead isEqualToString:@"1"]) {
        self.readBtn.customView.image = [UIImage imageNamed:@"icon_yuedu_d"];
        self.readBtn.customTitle.textColor = hexStringToColor(@"ff7451");
    }else {
        self.readBtn.customView.image = [UIImage imageNamed:@"icon_yuedu"];
        self.readBtn.customTitle.textColor = hexStringToColor(@"666666");
    }
    
    //    if ([model.isComment isEqualToString:@"1"]) {
    //        self.commentBtn.customView.image = [UIImage imageNamed:@"icon_yuedu_d"];
    //        self.commentBtn.customTitle.textColor = hexStringToColor(@"ff7451");
    //    }else {
    //        self.commentBtn.customView.image = [UIImage imageNamed:@"icon_pingjia"];
    //        self.commentBtn.customTitle.textColor = hexStringToColor(@"666666");
    //    }
    
    if ([model.isCollect isEqualToString:@"1"]) {
        self.collectBtn.customView.image = [UIImage imageNamed:@"icon_dianzhan"];
        self.collectBtn.customTitle.textColor = hexStringToColor(@"ff7451");
    }else {
        self.collectBtn.customView.image = [UIImage imageNamed:@"icon_like"];
        self.collectBtn.customTitle.textColor = hexStringToColor(@"666666");
    }
    
    //    if ([model.isForward isEqualToString:@"1"]) {
    //        self.forwardBtn.customView.image = [UIImage imageNamed:@"icon_zhuanfa_d"];
    //        self.forwardBtn.customTitle.textColor = hexStringToColor(@"ff7451");
    //    }else {
    //        self.forwardBtn.customView.image = [UIImage imageNamed:@"icon_zhuanfa_d"];
    //        self.forwardBtn.customTitle.textColor = hexStringToColor(@"666666");
    //    }
    if (![model.isShenping isEqualToString:@"1"]) {
        return;
    }
    NSString *str1 = [NSString stringWithFormat:@"%@：",model.shenpingAuthor];
    NSString *str2 = model.shenpingContent;
    //初始化
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] init];
    //空格间隙
    NSAttributedString *spaceString = [[NSAttributedString alloc] initWithString:@" "];
    //图片
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = [UIImage imageNamed:@"icon_huo"];
    attachment.bounds = CGRectMake(0, 0, 9, 12);
    NSAttributedString *imageAttachment = [NSAttributedString attributedStringWithAttachment:attachment];
    //图片
    [attributedString appendAttributedString:imageAttachment];
    //空格间隙
    [attributedString appendAttributedString:spaceString];
    
    //文字
    NSMutableAttributedString *textString1 = [[NSMutableAttributedString alloc] initWithString:str1];
    NSRange textRange1 = NSMakeRange(0, str1.length);
    //行间距
    NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
    style1.lineBreakMode = NSLineBreakByTruncatingTail;
    style1.lineSpacing = 5;
    [textString1 addAttribute:NSParagraphStyleAttributeName value:style1 range:textRange1];
    //文字颜色
    [textString1 addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"26c239") range:textRange1];
    //字体
    [textString1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 * layoutBy6()] range:textRange1];
    [attributedString appendAttributedString:textString1];
    
    //文字
    NSMutableAttributedString *textString2 = [[NSMutableAttributedString alloc] initWithString:str2];
    NSRange textRange2 = NSMakeRange(0, str2.length);
    //行间距
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    style2.lineBreakMode = NSLineBreakByTruncatingTail;
    style2.lineSpacing = 5;
    [textString2 addAttribute:NSParagraphStyleAttributeName value:style2 range:textRange2];
    //文字颜色
    [textString2 addAttribute:NSForegroundColorAttributeName value:hexStringToColor(@"666666") range:textRange2];
    //字体
    [textString2 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12 * layoutBy6()] range:textRange2];
    
    
    [attributedString appendAttributedString:textString2];
    self.shenpingLbl.attributedText = attributedString;
}

-(void)setupPicView {
    CGFloat margin = 5 * layoutBy6();
    CGFloat width = 115.5 * layoutBy6();
    CGFloat height = 60 * layoutBy6();
    NSInteger count = self.picArr.count;
    [self.picView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    self.itemsArr = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        CGFloat row = i/3;
        CGFloat col = i%3;
        KNPhotoItems *items = [[KNPhotoItems alloc] init];
        items.url = [self.picArr[i] stringByReplacingOccurrencesOfString:@"thumbnail" withString:@"bmiddle"];
        [self.itemsArr addObject:items];
        UIButton *btn = [[UIButton alloc] init];
        btn.tag = i;
        btn.frame = CGRectMake(15 * layoutBy6() + col * (width + margin) , row * (height + margin), width, height);
        [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.picArr[i]] forState:UIControlStateNormal];
        [self.picView addSubview:btn];
        [btn addTarget:self action:@selector(didClickImgBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
}

#pragma mark - 点击图片
-(void)didClickImgBtn:(UIButton *)btn {
    NSArray *arr= self.itemsArr.copy;
    
    if (self.picBtnCallBack) {
        self.picBtnCallBack(@(btn.tag), self.itemsArr.copy);
    }
}

-(void)didClickPersonal {
    if (self.personalCallBack) {
        self.personalCallBack(@(1));
    }
}

-(void)didClickTittle {
    if (self.titleCallBack) {
        self.titleCallBack(@(1));
    }
}

-(void)didClickContent {
    if (self.contentCallBack) {
        self.contentCallBack(@(1));
    }
}

-(void)didClickBottom:(CustomButton *)btn {
    if (self.bottomBtnCallBack) {
        self.bottomBtnCallBack(@(1));
    }
}

-(void)didClickShenping {
    if (self.shenpingCallBack) {
        self.shenpingCallBack(@(1));
    }
}

-(void)setupUI {
    self.contentView.backgroundColor = hexStringToColor(@"f5f7fb");
    [self.contentView addSubview:self.bgView];
    [self.contentView addSubview:self.authorView];
    [self.contentView addSubview:self.authorLbl];
    [self.contentView addSubview:self.iconView1];
    [self.contentView addSubview:self.iconView2];
    [self.contentView addSubview:self.iconView3];
    [self.contentView addSubview:self.dateLbl];
    [self.contentView addSubview:self.leijiLbl];
    [self.contentView addSubview:self.shenheNeirongLbl];
    [self.contentView addSubview:self.titleLbl];
    [self.contentView addSubview:self.contentLbl];
    [self.contentView addSubview:self.picView];
    
    [self.contentView addSubview:self.bottomView];
    [self.contentView addSubview:self.line];
    [self.bottomView addSubview:self.readBtn];
    [self.bottomView addSubview:self.commentBtn];
    [self.bottomView addSubview:self.collectBtn];
    [self.bottomView addSubview:self.forwardBtn];
    [self.contentView addSubview:self.shenpingBgView];
    [self.contentView addSubview:self.shenpingLbl];
}


-(void)layoutSubviews {
    [super layoutSubviews];
    self.bgView.frame = CGRectMake(0, 0 * layoutBy6(), J_SCREEN_WIDTH, self.model.cellHeight - 10 * layoutBy6());
    self.authorView.frame = CGRectMake(15 * layoutBy6(), self.bgView.top + 15 * layoutBy6(), 30 * layoutBy6(), 30 * layoutBy6());
    self.authorLbl.frame = CGRectMake(self.authorView.right + 9.5 * layoutBy6(), self.authorView.top, self.model.authorLblWidth, 13.5 * layoutBy6());
    self.iconView1.frame = CGRectMake(self.authorLbl.right + 2.5 * layoutBy6(), self.authorLbl.top + 1.25 * layoutBy6(), 15 * layoutBy6(), 10 * layoutBy6());
    self.iconView2.frame = CGRectMake(self.iconView1.right + 0.5 * layoutBy6(), self.iconView1.top - 0.5 * layoutBy6(), 13.5 * layoutBy6(), 11 * layoutBy6());
    self.iconView3.frame = CGRectMake(self.iconView2.right + 1 * layoutBy6(), self.iconView2.top, 30 * layoutBy6(), 11 * layoutBy6());
    self.dateLbl.frame = CGRectMake(self.authorLbl.left, self.authorLbl.bottom + 7.5 * layoutBy6(), 200 * layoutBy6(), 11 * layoutBy6());
    self.leijiLbl.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 100 * layoutBy6(), self.authorLbl.top, 100 * layoutBy6(), 10.5 * layoutBy6());
    self.shenheNeirongLbl.frame = CGRectMake(J_SCREEN_WIDTH - 15 * layoutBy6() - 100 * layoutBy6(), self.leijiLbl.bottom + 8 * layoutBy6(), 100 * layoutBy6(), 11 * layoutBy6());
    self.titleLbl.frame = CGRectMake(15 * layoutBy6(), self.authorView.bottom + 15 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), self.model.titleHeight);
    self.contentLbl.frame = CGRectMake(self.titleLbl.left, self.titleLbl.bottom + 8.5 * layoutBy6(), self.titleLbl.width, self.model.contentHeight);
    self.picView.frame = CGRectMake(0, self.contentLbl.bottom + 4 * layoutBy6(), J_SCREEN_WIDTH, self.model.picViewHeight);
    self.line.frame = CGRectMake(15 * layoutBy6(), self.picView.bottom + 10 * layoutBy6(), J_SCREEN_WIDTH - 30 * layoutBy6(), 0.5);
    self.bottomView.frame = CGRectMake(0, self.picView.bottom, J_SCREEN_WIDTH, 45 * layoutBy6());
    CGFloat margin = 30 * layoutBy6();
    CGFloat width = (J_SCREEN_WIDTH - 5 * margin)/4;
    CGFloat height = 35 * layoutBy6();
    self.readBtn.frame = CGRectMake(30 * layoutBy6(), 10 * layoutBy6(), width, height);
    self.readBtn.customView.frame = CGRectMake(3.5 * layoutBy6(), 12.5 * layoutBy6(), 16 * layoutBy6(), 10 * layoutBy6());
    self.readBtn.customTitle.frame = CGRectMake(self.readBtn.customView.right + 5.5 * layoutBy6(), self.readBtn.customView.top, self.readBtn.width - 5.5 * layoutBy6() - self.readBtn.customView.width, self.readBtn.customView.height);
    
    self.commentBtn.frame = CGRectMake(margin * 2 + width, 10 * layoutBy6(), width, height);
    self.commentBtn.customView.frame = CGRectMake(3.5 * layoutBy6(), 11 * layoutBy6(), 13 * layoutBy6(), 12 * layoutBy6());
    self.commentBtn.customTitle.frame = CGRectMake(self.commentBtn.customView.right + 5.5 * layoutBy6(), self.commentBtn.customView.top, self.commentBtn.width - 5.5 * layoutBy6() - self.commentBtn.customView.width, self.commentBtn.customView.height);
    
    self.collectBtn.frame = CGRectMake(margin * 3 + width * 2, 10 * layoutBy6(), width, height);
    self.collectBtn.customView.frame = CGRectMake(3.5 * layoutBy6(), 11 * layoutBy6(), 13 * layoutBy6(), 12 * layoutBy6());
    self.collectBtn.customTitle.frame = CGRectMake(self.collectBtn.customView.right + 5.5 * layoutBy6(), self.collectBtn.customView.top, self.collectBtn.width - 5.5 * layoutBy6() - self.collectBtn.customView.width, self.collectBtn.customView.height);
    
    self.forwardBtn.frame = CGRectMake(margin * 4 + width * 3, 10 * layoutBy6(), width, height);
    self.forwardBtn.customView.frame = CGRectMake(3.5 * layoutBy6(), 11 * layoutBy6(), 12 * layoutBy6(), 12 * layoutBy6());
    self.forwardBtn.customTitle.frame = CGRectMake(self.forwardBtn.customView.right + 5.5 * layoutBy6(), self.forwardBtn.customView.top, self.forwardBtn.width - 5.5 * layoutBy6() - self.forwardBtn.customView.width, self.forwardBtn.customView.height);
    
    self.shenpingBgView.frame = CGRectMake(15 * layoutBy6(), self.bottomView.bottom, J_SCREEN_WIDTH - 30 * layoutBy6(), self.model.shenpingHeight);
    self.shenpingLbl.frame = CGRectMake(self.shenpingBgView.left + 15 * layoutBy6(), self.shenpingBgView.top + 10 * layoutBy6(), self.shenpingBgView.width - 30 * layoutBy6(), self.model.shenpingHeight - 20 * layoutBy6());
}

-(UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bgView;
}

-(UIImageView *)authorView {
    if (!_authorView) {
        _authorView = [[UIImageView alloc] init];
        _authorView.layer.cornerRadius = 15 * layoutBy6();
        _authorView.layer.masksToBounds = YES;
        _authorView.image = [UIImage imageNamed:@"shouye_logo"];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonal)];
        [_authorView addGestureRecognizer:tap];
        _authorView.userInteractionEnabled = YES;
    }
    return _authorView;
}

-(UILabel *)authorLbl {
    if (!_authorLbl) {
        _authorLbl = [[UILabel alloc] init];
        _authorLbl.textColor = hexStringToColor(@"333333");
        _authorLbl.font = [UIFont systemFontOfSize:14 * layoutBy6()];
        _authorLbl.textAlignment = NSTextAlignmentLeft;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickPersonal)];
        [_authorLbl addGestureRecognizer:tap];
        _authorLbl.userInteractionEnabled = YES;
    }
    return _authorLbl;
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

-(UILabel *)dateLbl {
    if (!_dateLbl) {
        _dateLbl = [[UILabel alloc] init];
        _dateLbl.textColor = hexStringToColor(@"999999");
        _dateLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
    }
    return _dateLbl;
}

-(UILabel *)leijiLbl {
    if (!_leijiLbl) {
        _leijiLbl = [[UILabel alloc] init];
        _leijiLbl.textColor = hexStringToColor(@"999999");
        _leijiLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _leijiLbl.textAlignment = NSTextAlignmentRight;
    }
    return _leijiLbl;
}

-(UILabel *)shenheNeirongLbl {
    if (!_shenheNeirongLbl) {
        _shenheNeirongLbl = [[UILabel alloc] init];
        _shenheNeirongLbl.text = @"审核内容为非法";
        _shenheNeirongLbl.textColor = hexStringToColor(@"ff7451");
        _shenheNeirongLbl.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _shenheNeirongLbl.textAlignment = NSTextAlignmentRight;
    }
    return _shenheNeirongLbl;
}

-(UILabel *)titleLbl {
    if (!_titleLbl) {
        _titleLbl = [[UILabel alloc] init];
        _titleLbl.textColor = hexStringToColor(@"333333");
        _titleLbl.font = [UIFont systemFontOfSize:15 * layoutBy6()];
        _titleLbl.textAlignment = NSTextAlignmentLeft;
        _titleLbl.numberOfLines = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickTittle)];
        [_titleLbl addGestureRecognizer:tap];
        _titleLbl.userInteractionEnabled = YES;
    }
    return _titleLbl;
}

-(UILabel *)contentLbl {
    if (!_contentLbl) {
        _contentLbl = [[UILabel alloc] init];
        _contentLbl.textColor = hexStringToColor(@"666666");
        _contentLbl.font = [UIFont systemFontOfSize:13 * layoutBy6()];
        _contentLbl.textAlignment = NSTextAlignmentLeft;
        _contentLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _contentLbl.numberOfLines = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickContent)];
        [_contentLbl addGestureRecognizer:tap];
        _contentLbl.userInteractionEnabled = YES;
    }
    return _contentLbl;
}

-(UIView *)picView {
    if (!_picView) {
        _picView = [[UIView alloc] init];
        _picView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _picView;
}

-(UIView *)line {
    if (!_line) {
        _line = [[UIView alloc] init];
        _line.backgroundColor = hexStringToColor(@"e9e9e9");
    }
    return _line;
}

-(UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = hexStringToColor(@"ffffff");
    }
    return _bottomView;
}

-(CustomButton *)readBtn {
    if (!_readBtn) {
        _readBtn = [[CustomButton alloc] init];
        _readBtn.customTitle.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _readBtn.tag = 10;
        [_readBtn addTarget:self action:@selector(didClickBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _readBtn;
}

-(CustomButton *)commentBtn {
    if (!_commentBtn) {
        _commentBtn = [[CustomButton alloc] init];
        _commentBtn.customView.image = [UIImage imageNamed:@"icon_pingjia"];
        _commentBtn.customTitle.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _commentBtn.tag = 20;
        [_commentBtn addTarget:self action:@selector(didClickBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _commentBtn;
}

-(CustomButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn = [[CustomButton alloc] init];
        _collectBtn.customTitle.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _collectBtn.tag = 30;
        [_collectBtn addTarget:self action:@selector(didClickBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}

-(CustomButton *)forwardBtn {
    if (!_forwardBtn) {
        _forwardBtn = [[CustomButton alloc] init];
        _forwardBtn.customView.image = [UIImage imageNamed:@"icon_zhuanfa_d"];
        _forwardBtn.customTitle.font = [UIFont systemFontOfSize:11 * layoutBy6()];
        _forwardBtn.tag = 40;
        [_forwardBtn addTarget:self action:@selector(didClickBottom:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _forwardBtn;
}

-(UIView *)shenpingBgView {
    if (!_shenpingBgView) {
        _shenpingBgView = [[UIView alloc] init];
        _shenpingBgView.backgroundColor = hexStringToColor(@"fafafa");
    }
    return _shenpingBgView;
}

-(UILabel *)shenpingLbl  {
    if (!_shenpingLbl) {
        _shenpingLbl = [[UILabel alloc] init];
        _shenpingLbl.font = [UIFont systemFontOfSize:12 * layoutBy6()];
        _shenpingLbl.textAlignment = NSTextAlignmentLeft;
        _shenpingLbl.lineBreakMode = NSLineBreakByTruncatingTail;
        _shenpingLbl.numberOfLines = 3;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickShenping)];
        [_shenpingLbl addGestureRecognizer:tap];
        _shenpingLbl.userInteractionEnabled = YES;
    }
    return _shenpingLbl;
}

@end
