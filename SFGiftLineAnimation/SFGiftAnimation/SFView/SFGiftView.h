//
//  SFGiftView.h
//  SFGiftLineAnimation
//
//  Created by cnlive-lsf on 2016/11/17.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFGiftLineModel.h"

@interface SFGiftView : UIView
@property (weak, nonatomic) IBOutlet UILabel *senderName;
@property (weak, nonatomic) IBOutlet UILabel *giftName;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *markStr;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, strong) SFGiftLineModel *model;
@property (nonatomic, assign) BOOL isShow;

+ (SFGiftView *)initForNib;
- (void)configureModel:(SFGiftLineModel *)configureModel;
@end
