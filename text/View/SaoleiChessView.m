//
//  SaoleiChessView.m
//  text
//
//  Created by hanlu on 16/8/1.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaoleiChessView.h"

#define rgba(r,g,b,a) [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:a]



@interface SaoleiChessView ()

@end

@implementation SaoleiChessView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self setBackgroundImage:[UIImage imageNamed:@"tile_0_mask"] forState:(UIControlStateNormal)];
    
}

- (void)setPosition:(Position *)position {
    _position = position;
    
    self.tag = 100 * position.y + position.x ;
}

- (void)setClickKind:(SaoleiUserClickKind)clickKind {
    _clickKind = clickKind;
    
    switch (clickKind) {
        case SaoleiUserClickKindNormal:{
            [self setBackgroundImage:[UIImage imageNamed:@"tile_0_mask~hd"] forState:(UIControlStateNormal)];
        }
            break;
        case SaoleiUserClickKindQusetion:{
            [self setBackgroundImage:[UIImage imageNamed:@"tile_0_hint_q~hd"] forState:(UIControlStateNormal)];
        }
            break;
        case SaoleiUserClickKindFlag:{
            [self setBackgroundImage:[UIImage imageNamed:@"tile_0_d"] forState:(UIControlStateNormal)];
        }
            break;
    }
}

- (void)changeBack {
    self.enabled = YES;
    
    self.clickKind = SaoleiUserClickKindNormal;
    
    self.isLei = NO;
    
    self.numberOfLei = 0;
}

- (void)show {
    if (self.enabled) {
        if (self.isLei) {
            if (self.clickKind != SaoleiUserClickKindFlag) {
                [self setBackgroundImage:[UIImage imageNamed:@"tile_0_b2~hd"] forState:(UIControlStateDisabled)];
                
                self.enabled = NO;
            }
        } else {
            if (self.clickKind == SaoleiUserClickKindFlag) {
                [self setBackgroundImage:[UIImage imageNamed:@"tile_0_b3~hd"] forState:(UIControlStateDisabled)];
                
                self.enabled = NO;
            }
        }
    }
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ 雷的数量:%ld 自己是否石雷:%u",self.position,self.numberOfLei,self.isLei];
}

@end
