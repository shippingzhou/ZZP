//
//  TLLvyouQuanModel.m
//  他律
//
//  Created by sineboy on 2019/12/22.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLLvyouQuanModel.h"

@implementation TLLvyouQuanModel

-(void)setContent:(NSString *)content {
    _content = content;
    CGFloat height = [[Untils defaultUntils] heightForString:content fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 30 * layoutBy6() andHeight:70 * layoutBy6() isBoldMT:NO];
    self.contentHeight = height;
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6() + self.shenpingHeight;
}

-(void)setTitle:(NSString *)title {
    _title = title;
    self.titleHeight = [[Untils defaultUntils] heightForString:title fontSize:15 * layoutBy6() andWidth:J_SCREEN_WIDTH - 30 * layoutBy6() andHeight:100 * layoutBy6() isBoldMT:NO];
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6() + self.shenpingHeight;
}

-(void)setImgs:(NSString *)imgs {
    _imgs = imgs;
    NSArray *arr = [imgs componentsSeparatedByString:@","];
    NSInteger count = arr.count;
    if (count <= 3 && count > 0) {
        self.picViewHeight = 60 * layoutBy6();
    }else if(count > 3) {
        self.picViewHeight = 85 * layoutBy6();
    }else {
        self.picViewHeight = 0;
    }
    if ([imgs isEqualToString:@""]) {
        self.picViewHeight = 0;
    }
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6();
}

-(void)setAuthorName:(NSString *)authorName {
    _authorName = authorName;
    self.authorLblWidth = [[Untils defaultUntils] widthForString:authorName fontSize:14 * layoutBy6() andWidth:200 * layoutBy6() andHeight:20 * layoutBy6() isBoldMT:NO];
}

-(void)setShenpingAuthor:(NSString *)shenpingAuthor {
    _shenpingAuthor = shenpingAuthor;
    NSString *str = [NSString stringWithFormat:@"🔥%@：%@",self.shenpingAuthor,self.shenpingContent];
    CGFloat height = [[Untils defaultUntils] heightForString:str fontSize:12 * layoutBy6() andWidth:J_SCREEN_WIDTH - 30 * layoutBy6() - 30 * layoutBy6() andHeight:100 * layoutBy6() isBoldMT:NO];
    ;
    if ([self.isShenping isEqualToString:@"1"]) {
        self.shenpingHeight = height;
    }else {
        self.shenpingHeight = 0;
    }
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6() + self.shenpingHeight;
}

-(void)setShenpingContent:(NSString *)shenpingContent {
    _shenpingContent = shenpingContent;
    NSString *str = [NSString stringWithFormat:@"🔥%@：%@",self.shenpingAuthor,self.shenpingContent];
    CGFloat height = [[Untils defaultUntils] heightForString:str fontSize:12 * layoutBy6() andWidth:J_SCREEN_WIDTH - 30 * layoutBy6() - 30 * layoutBy6() andHeight:100 * layoutBy6() isBoldMT:NO] + 20 * layoutBy6();
    if ([self.isShenping isEqualToString:@"1"]) {
        self.shenpingHeight = height;
    }else {
        self.shenpingHeight = 0;
    }
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6() + self.shenpingHeight;
}

-(void)setIsShenping:(NSString *)isShenping {
    _isShenping = isShenping;
    NSString *str = [NSString stringWithFormat:@"🔥%@：%@",self.shenpingAuthor,self.shenpingContent];
    CGFloat height = [[Untils defaultUntils] heightForString:str fontSize:12 * layoutBy6() andWidth:J_SCREEN_WIDTH - 30 * layoutBy6() - 30 * layoutBy6() andHeight:100 * layoutBy6() isBoldMT:NO] + 20 * layoutBy6();
    if ([self.isShenping isEqualToString:@"1"]) {
        self.shenpingHeight = height;
    }else {
        self.shenpingHeight = 0;
    }
    self.cellHeight = self.contentHeight + self.picViewHeight + self.titleHeight + 140 * layoutBy6() + self.shenpingHeight;
}

@end
