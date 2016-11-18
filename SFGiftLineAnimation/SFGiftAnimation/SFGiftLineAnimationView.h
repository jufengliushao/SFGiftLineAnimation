//
//  SFGiftLineAnimationView.h
//  SFGiftLineAnimation
//
//  Created by cnlive-lsf on 2016/11/17.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFGiftView.h"

typedef NS_ENUM(NSInteger, SFSHOW_DIRECTION){
    SF_LEFT_SHOW_DIRECTION, /** 从左边到右边移动 from left to right default */
    SF_RIGHT_SHOW_DIRECTION /** 从右边到左边 from right to left */
};

typedef NS_ENUM(NSInteger, SFGIFT_SHOW_STYLE) {
    SF_TOGETHER_GIFT_SHOW, /** 礼物一起出现，有时间间隔 gifts together show default */
    SF_ONE_GIFT_SHOW /** 礼物一个一个出现，第一个展示完成，第二个出现 gifts shows one by one */
};

@interface SFGiftLineAnimationView : UIView
/**
 动画属性
 animation properties
 */
@property (nonatomic, assign) CGFloat duration; /** 动画展示时间 one gift-view animation time default 2s */
@property (nonatomic, assign) CGFloat delay; /** 动画延迟时间 one gift-view animation delay time default 0s */
@property (nonatomic, assign) CGFloat togetherSpace; /** gift-view一起出现之间的时间间隔 gift-view show together delay time default 0.5s */

/**
 gift view 属性
 gift-view properties
 */
@property (nonatomic, assign) CGFloat gift_width; /** gift-view width default auto */
@property (nonatomic, assign) CGFloat gift_height; /** gift-view height default 35pt */

- (instancetype)initWithDirection:(SFSHOW_DIRECTION)showDirection showStyle:(SFGIFT_SHOW_STYLE)showStyle;
- (void)addDataArray:(NSArray *)array;
@end
