//
//  PaihangTableViewCell.h
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UserModel;
@interface PaihangTableViewCell : UITableViewCell

@property (nonatomic,assign) NSInteger ranking;

@property (nonatomic,strong) UserModel *model;

@end
