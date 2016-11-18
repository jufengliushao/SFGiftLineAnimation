//
//  SFMainViewController.m
//  SFGiftLineAnimation
//
//  Created by cnlive-lsf on 2016/11/17.
//  Copyright © 2016年 cnlive-lsf. All rights reserved.
//

#import "SFMainViewController.h"
#import "SFGiftLineAnimationView.h"

@interface SFMainViewController ()
@property (nonatomic, strong) SFGiftLineAnimationView *sfGiftLineView;
@end

@implementation SFMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.sfGiftLineView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(addGiftData:)];
    [self.view addGestureRecognizer:tap];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -------------------Action------------------
- (void)addGiftData:(UITapGestureRecognizer *)tap{
    SFGiftLineModel *model0 = [[SFGiftLineModel alloc] init];
    model0.sender = @"柯南";
    model0.giftName = @"毛利兰";
    
    SFGiftLineModel *model1 = [[SFGiftLineModel alloc] init];
    model1.sender = @"柯南";
    model1.giftName = @"毛利兰";
    
    SFGiftLineModel *model2 = [[SFGiftLineModel alloc] init];
    model2.sender = @"柯南 & 毛利兰";
    model2.giftName = @"园子 & 灰原哀";
    
    [self.sfGiftLineView addDataArray:@[model0, model1, model2]];
}

#pragma mark -------------------sfGiftLineView---------------
- (SFGiftLineAnimationView *)sfGiftLineView{
    if (!_sfGiftLineView) {
        _sfGiftLineView = [[SFGiftLineAnimationView alloc] initWithDirection:SF_RIGHT_SHOW_DIRECTION showStyle:SF_TOGETHER_GIFT_SHOW];
        _sfGiftLineView.frame = CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 50);
        _sfGiftLineView.backgroundColor = [UIColor orangeColor];
    }
    return _sfGiftLineView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end