//
//  SFGiftLineAnimationView.m
//  SFGiftLineAnimation
//
//  Created by cnlive-lsf on 2016/11/17.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFGiftLineAnimationView.h"


@interface SFGiftLineAnimationView(){
    NSMutableArray *_dataArray;
    NSMutableArray *_giftViewArr;
    BOOL _isAnimating;
    SFGiftView *_currentGV;
}
@property (nonatomic, assign) SFSHOW_DIRECTION showDirection;
@property (nonatomic, assign) SFGIFT_SHOW_STYLE showStyle;
@property (nonatomic, strong) NSTimer *togetherTimer;
@end

@implementation SFGiftLineAnimationView
- (instancetype)initWithDirection:(SFSHOW_DIRECTION)showDirection showStyle:(SFGIFT_SHOW_STYLE)showStyle{
    if (self = [super init]) {
        if (showDirection) {
            self.showDirection = showDirection;
        }else{
            self.showDirection = SF_LEFT_SHOW_DIRECTION;
        }
        if (showStyle) {
            self.showStyle = showStyle;
        }else{
            self.showStyle = SF_TOGETHER_GIFT_SHOW;
        }
        _giftViewArr = [NSMutableArray arrayWithCapacity:0];
        _isAnimating = NO;
    }
    return self;
}

#pragma mark ---------------Action---------------------
- (void)startAnimation{
    if (self.showStyle == SF_TOGETHER_GIFT_SHOW) {
        // SF_TOGETHER_GIFT_SHOW
        if (!_togetherTimer) {
            [self.togetherTimer fire];
        }
        [self togetherAnimation];
    }else{
        // SF_ONE_GIFT_SHOW
        [self oneByOneAnimation];
    }
}

- (void)oneByOneAnimation{
    if (_giftViewArr.count != 0) {
        [self animationShowOneByOneWithView:_giftViewArr[0]];
    }else{
        _isAnimating = NO;
    }
}

- (void)togetherAnimation{
    if (_giftViewArr.count != 0) {
        for (SFGiftView *view in _giftViewArr) {
            if (view.isShow == NO) {
                _currentGV = view;
                [self togetherAnimationWithView:view];
                break;
            }
        }
    }else{
        _isAnimating = NO;
        _currentGV = nil;
        [self.togetherTimer invalidate];
        self.togetherTimer = nil;
    }
}

- (void)togetherCanShow{
    NSLog(@"=====%f", _currentGV.layer.presentationLayer.frame.origin.x);
    NSLog(@"+++++%f", _currentGV.width + self.togetherSpace);
    if (_currentGV.layer.presentationLayer.frame.origin.x == 0.0) {
        return;
    }
    if (self.showDirection == SF_LEFT_SHOW_DIRECTION) {
        if (_currentGV.layer.presentationLayer.frame.origin.x >= self.togetherSpace) {
            [self startAnimation];
        }
    }else{
        if (_currentGV.layer.presentationLayer.frame.origin.x <= self.bounds.size.width - _currentGV.width - self.togetherSpace) {
            [self startAnimation];
        }
    }
}
#pragma mark ---------------Animation------------------
- (void)animationShowOneByOneWithView:(SFGiftView *)giftView{
    giftView.isShow = YES;
    giftView.hidden = NO;
    CGFloat dura = (giftView.width + self.bounds.size.width + self.togetherSpace) * self.speed;
    [UIView animateWithDuration:dura delay:self.delay options:UIViewAnimationOptionCurveLinear animations:^{
        giftView.frame = [self returnFinalFrameWithView:giftView];
    } completion:^(BOOL finished) {
        [_giftViewArr removeObject:giftView];
        [_dataArray removeObject:giftView.model];
        [self startAnimation];
    }];
}

- (void)togetherAnimationWithView:(SFGiftView *)giftView{
    giftView.isShow = YES;
    giftView.hidden = NO;
    CGFloat dura = (giftView.width + self.bounds.size.width + self.togetherSpace) * self.speed;
    [UIView animateWithDuration:dura delay:self.delay options:UIViewAnimationOptionCurveLinear animations:^{
        giftView.frame = [self returnFinalFrameWithView:giftView];
        
    } completion:^(BOOL finished) {
        [_giftViewArr removeObject:giftView];
        [_dataArray removeObject:giftView.model];
    }];
}

#pragma mark -------------------Tool---------------------
- (SFGiftView *)returnGiftView{
    SFGiftView *giftView = [SFGiftView initForNib];
    giftView.hidden = YES;
    giftView.isShow = NO;
    return giftView;
}

- (CGRect)returnInitFrameWithView:(SFGiftView *)giftView{
    CGRect frame;
    CGFloat x = self.frame.size.width + 20;
    if (self.showDirection == SF_LEFT_SHOW_DIRECTION) {
        x = - giftView.width - 20.f;
    }
    frame = CGRectMake(x, (self.bounds.size.height - self.gift_height) / 2.f, giftView.width, self.gift_height);
    return frame;
}

- (CGRect)returnFinalFrameWithView:(SFGiftView *)giftView{
    CGFloat x = self.bounds.size.width + 20.f;
    if (self.showDirection == SF_RIGHT_SHOW_DIRECTION) {
        x = -giftView.width - 20.f;
    }
    CGRect frame = CGRectMake(x, giftView.frame.origin.y, giftView.bounds.size.width, giftView.bounds.size.height);
    return frame;
}

- (void)addGiftViewWithModel:(SFGiftLineModel *)model{
    SFGiftView *view = [self returnGiftView];
    [view configureModel:model];
    view.frame = [self returnInitFrameWithView:view];
    [self addSubview:view];
    [_giftViewArr addObject:view];
}

- (void)addDataArray:(NSArray *)array{
    for (SFGiftLineModel *model in array) {
        [self addGiftViewWithModel:model];
    }
    [_dataArray addObjectsFromArray:array];
    if (!_isAnimating) {
        _isAnimating = YES;
        [self startAnimation];
    }
}
#pragma mark ----------------GET-----------
- (CGFloat)duration{
    if (!_duration) {
        _duration = 5.f;
    }
    return _duration;
}

- (CGFloat)delay{
    if (!_delay) {
        _delay = 0;
    }
    return _delay;
}

- (CGFloat)gift_height{
    if (!_gift_height) {
        _gift_height = 35;
    }
    return _gift_height;
}

- (CGFloat)togetherSpace{
    if (!_togetherSpace) {
        _togetherSpace = 30;
    }
    return _togetherSpace;
}

- (CGFloat)speed{
    if (!_speed) {
        _speed = self.duration / (self.bounds.size.width + 162.f + self.togetherSpace);
    }
    return _speed;
}

- (NSTimer *)togetherTimer{
    if (!_togetherTimer) {
        _togetherTimer = [NSTimer scheduledTimerWithTimeInterval:0.01
                                                          target:self
                                                        selector:@selector(togetherCanShow)
                                                        userInfo:nil
                                                         repeats:YES];
    }
    return _togetherTimer;
}
@end
