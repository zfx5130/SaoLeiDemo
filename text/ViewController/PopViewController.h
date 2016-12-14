//
//  PopViewController.h
//  UIPresentationVCtest
//
//  Created by Aotu on 16/4/11.
//  Copyright © 2016年 Aotu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopViewController;
@protocol PopViewControllerDelegate <NSObject>

- (void)popViewController:(PopViewController *)popViewController didselectedWith:(NSInteger)indexPathRow;

@end

@interface PopViewController : UIViewController

@property (nonatomic,weak) id <PopViewControllerDelegate> delegate;

@end
