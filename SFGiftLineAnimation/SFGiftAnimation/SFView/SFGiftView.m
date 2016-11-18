//
//  SFGiftView.m
//  SFGiftLineAnimation
//
//  Created by cnlive-lsf on 2016/11/17.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFGiftView.h"

@implementation SFGiftView
+ (SFGiftView *)initForNib{
    NSArray *nibArr = [[NSBundle mainBundle] loadNibNamed:@"SFGiftView" owner:nil options:nil];
    return nibArr[0];
}

- (void)configureModel:(SFGiftLineModel *)configureModel{
    self.model = configureModel;
    self.senderName.text = configureModel.sender;
    self.giftName.text = configureModel.giftName;
    [self configureSelfWidth];
}

#pragma mark ----------------------------------
- (void)configureSelfWidth{
    self.width = [self returnWidthWithFont:self.senderName.font str:self.senderName.text] + 10 + [self returnWidthWithFont:self.markStr.font str:self.markStr.text] + 10 + [self returnWidthWithFont:self.giftName.font str:self.giftName.text] + 20 + 10;
}

- (CGFloat)returnWidthWithFont:(UIFont *)font str:(NSString *)str{
    NSDictionary *dict = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
    CGRect bounds = [str boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil];
    return bounds.size.width;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
