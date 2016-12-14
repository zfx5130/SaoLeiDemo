//
//  SaoleiHeaderView.h
//  text
//
//  Created by hanlu on 16/8/2.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SaoleiNumberOrTimeImageView;
typedef NS_ENUM(NSInteger,RestartKind) {
    RestartKindNormal,
    RestartKindWin,
    RestartKindLose
};

@interface SaoleiHeaderView : UIView
/**
 *  有多少个雷的视图
 */
@property (nonatomic,strong) SaoleiNumberOrTimeImageView *numberOfLeiView;
/**
 *  重新开始按钮
 */
@property (nonatomic,strong) UIButton *restartButton;
/**
 *  还剩多少秒的视图
 */
@property (nonatomic,strong) SaoleiNumberOrTimeImageView *timeOfLeiView;
/**
 *  重新开始按钮的样式
 */
@property (nonatomic,assign) RestartKind restartKind;

@end
