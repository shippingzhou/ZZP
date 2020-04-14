//
//  TLNotificationModel.m
//  他律
//
//  Created by sineboy on 2019/12/26.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLNotificationModel.h"

@implementation TLNotificationModel

-(void)setContent:(NSString *)content {
    _content = content;
    CGFloat height = [[Untils defaultUntils] heightForString:content fontSize:11 * layoutBy6() andWidth:J_SCREEN_WIDTH - 90 * layoutBy6() andHeight:52 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    self.contentHeight = height;
    if ([self.comment isEqualToString:@""]) {
        
        if ([self.title isEqualToString:@""]) {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6();
        }else {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }else {
        if ([self.title isEqualToString:@""]) {
            self.bgViewHeight1 = self.contentHeight + 20 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6();
        }else {
            self.bgViewHeight1 = self.contentHeight + 42.5 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }
    
}

-(void)setTitle:(NSString *)title {
    _title = title;
    if ([self.comment isEqualToString:@""]) {
        
        if ([self.title isEqualToString:@""]) {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6();
        }else {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }else {
        if ([self.title isEqualToString:@""]) {
            self.bgViewHeight1 = self.contentHeight + 20 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6();
        }else {
            self.bgViewHeight1 = self.contentHeight + 42.5 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }
}

-(void)setComment:(NSString *)comment {
    _comment = comment;
    self.commentHeight = [[Untils defaultUntils] heightForString:comment fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 80 * layoutBy6() andHeight:40 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    if ([self.comment isEqualToString:@""]) {
        
        if ([self.title isEqualToString:@""]) {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6();
        }else {
            self.cellHeight = self.contentHeight + self.commentHeight + 109.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }else {
        if ([self.title isEqualToString:@""]) {
            self.bgViewHeight1 = self.contentHeight + 20 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6();
        }else {
            self.bgViewHeight1 = self.contentHeight + 42.5 * layoutBy6();
            self.bgViewHeight2 = self.bgViewHeight1 + self.commentHeight + 25 * layoutBy6();
            self.cellHeight = self.contentHeight + self.commentHeight + 129.5 * layoutBy6() + 24.5 * layoutBy6();
        }
    }
}

-(void)setAuthorName:(NSString *)authorName {
    _authorName = authorName;
    self.authorLblWidth = [[Untils defaultUntils] widthForString:authorName fontSize:13 * layoutBy6() andWidth:200 * layoutBy6() andHeight:20 * layoutBy6() isBoldMT:NO];
}

@end
