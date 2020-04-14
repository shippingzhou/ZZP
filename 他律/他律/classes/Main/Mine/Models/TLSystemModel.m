//
//  TLSystemModel.m
//  他律
//
//  Created by sineboy on 2019/12/27.
//  Copyright © 2019 com. All rights reserved.
//

#import "TLSystemModel.h"

@implementation TLSystemModel

-(void)setContent:(NSString *)content {
    _content = content;
    self.contentHeight = [[Untils defaultUntils] heightForString:content fontSize:11 * layoutBy6() andWidth:J_SCREEN_WIDTH - 68 * layoutBy6() andHeight:52 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
    self.cellHeight = self.contentHeight + 92.5 * layoutBy6();
}

-(void)setIsOpen:(BOOL)isOpen {
    _isOpen = isOpen;
    if (!self.isOpen) {
        self.systemContentHeight = [[Untils defaultUntils] heightForString:self.systemContent fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 40 * layoutBy6() andHeight:48 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
        self.systemCellHeight = self.systemContentHeight + 70 * layoutBy6();
    }else {
        self.systemContentHeight = [[Untils defaultUntils] heightForString:self.systemContent fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 40 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO] + 2 * layoutBy6();
        self.systemCellHeight = self.systemContentHeight + 70 * layoutBy6();
    }
}

-(void)setSystemContent:(NSString *)systemContent {
    _systemContent = systemContent;
    
    if (!self.isOpen) {
        self.systemContentHeight = [[Untils defaultUntils] heightForString:systemContent fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 40 * layoutBy6() andHeight:48 * layoutBy6() isBoldMT:NO] + 2 * layoutBy6();
        self.systemCellHeight = self.systemContentHeight + 70 * layoutBy6();
    }else {
        self.systemContentHeight = [[Untils defaultUntils] heightForString:systemContent fontSize:13 * layoutBy6() andWidth:J_SCREEN_WIDTH - 40 * layoutBy6() andHeight:CGFLOAT_MAX isBoldMT:NO] + 2 * layoutBy6();
        self.systemCellHeight = self.systemContentHeight + 70 * layoutBy6();
    }
}

@end
