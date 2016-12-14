//
//  SaoleiView.m
//  text
//
//  Created by hanlu on 16/8/1.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaoleiView.h"
#import "SaoleiViewController.h"
#define WD_width self.frame.size.width
#define WD_height self.frame.size.height

CGFloat const lineWidth = 0;

@implementation SaoleiView
- (instancetype)initWithFrame:(CGRect)frame NumberOfChessInLine:(NSInteger)numberOfChessInLine NumberOfChessInList:(NSInteger)numberOfChessInList ViewController:(SaoleiViewController *)vc
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _numberOfChessInLine = numberOfChessInLine;
        
        _numberOfChessInList = numberOfChessInList;
        
        _vc = vc;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat width = (WD_width - lineWidth * (self.numberOfChessInLine - 1)) / self.numberOfChessInLine;
    
    CGFloat height = (WD_height - lineWidth * (self.numberOfChessInList - 1)) / self.numberOfChessInList;
    
    for (int x = 0; x < self.numberOfChessInLine; x ++) {
        for (int y = 0; y < self.numberOfChessInLine; y ++) {
            SaoleiChessView *chess = [[SaoleiChessView alloc] initWithFrame:CGRectMake((lineWidth + width) * x , (lineWidth + height) * y, width, height)];
            
            chess.position = [Position positionWithX:x + 1 andY:y + 1];
            
            [chess addTarget:_vc action:@selector(buttonDidClicked:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [self addSubview:chess];
        }
    }
    
}

- (void)getRestarted {
    for (SaoleiChessView *chess in self.subviews) {
        [chess changeBack];
    }
}

- (void)showAll {
    for (SaoleiChessView *view in self.subviews) {
        [view show];
    }
}

- (SaoleiChessView *)viewWithPostion:(Position *)position {
    return [self viewWithTag:100 * position.y + position.x];
}

- (void)resetView {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    
    [self setupUI];
}

@end
