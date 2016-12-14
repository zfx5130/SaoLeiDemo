//
//  SaoleiFooterView.m
//  text
//
//  Created by hanlu on 16/8/2.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaoleiFooterView.h"
#define WD_width self.frame.size.width
#define WD_height self.frame.size.height
@implementation SaoleiFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _flagButton = [[UIButton alloc] initWithFrame:CGRectMake(WD_width / 4 - 25, WD_height / 2 - 25, 50, 50)];
    
    _flagButton.tag = 1;
    
    [_flagButton setBackgroundImage:[UIImage imageNamed:@"tile_1_d~hd"] forState:(UIControlStateNormal)];
    
    [self addSubview:_flagButton];
    
    _normalButton = [[UIButton alloc] initWithFrame:CGRectMake(WD_width / 2 - 25, WD_height / 2 - 25, 50, 50)];
    
    _normalButton.tag = 0;
    
    [_normalButton setBackgroundImage:[UIImage imageNamed:@"tile_1_mask_down~hd"] forState:(UIControlStateNormal)];
    
    [self addSubview:_normalButton];
    
    _questionButton = [[UIButton alloc] initWithFrame:CGRectMake(WD_width / 4 * 3 - 25, WD_height / 2 - 25, 50, 50)];
    
    _questionButton.tag = 2;
    
    [_questionButton setBackgroundImage:[UIImage imageNamed:@"tile_1_hint_q~hd"] forState:(UIControlStateNormal)];
    
    [self addSubview:_questionButton];
}
@end
