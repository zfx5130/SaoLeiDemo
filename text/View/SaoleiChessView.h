//
//  SaoleiChessView.h
//  text
//
//  Created by hanlu on 16/8/1.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Position.h"
/**
 *  用户点击的方式
 */
typedef NS_ENUM(NSInteger,SaoleiUserClickKind) {
    /**
     *  正常点击（可以触发雷）
     */
    SaoleiUserClickKindNormal,
    /**
     *  插棋子（排雷）
     */
    SaoleiUserClickKindFlag,
    /**
     *  放置问号（不做任何改变）
     */
    SaoleiUserClickKindQusetion
};

@interface SaoleiChessView : UIButton
/**
 *  用户点击属性(用户以什么方式点击的)
 */
@property (nonatomic,assign) SaoleiUserClickKind clickKind;
/**
 *  棋子位置
 */
@property (nonatomic,strong) Position *position;
/**
 *  棋子周围的雷数
 */
@property (nonatomic,assign) NSInteger numberOfLei;
/**
 *  是否是雷
    默认是NO
 */
@property (nonatomic,assign) BOOL isLei;
/**
 *  是否能被正常点击
    默认是YES
    该属性暂无用处
 */
@property (nonatomic,assign) BOOL canNormalPress;
/**
 *  恢复原样
 */
- (void)changeBack;
/**
 *  展示自己
 */
- (void)show;

@end
