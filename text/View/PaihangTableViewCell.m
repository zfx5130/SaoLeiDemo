//
//  PaihangTableViewCell.m
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "PaihangTableViewCell.h"
#import "UserModel.h"

@interface PaihangTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *rankingLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameModel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation PaihangTableViewCell

- (void)setModel:(UserModel *)model {
    _model = model;
    
    _nameModel.text = [NSString stringWithFormat:@"用户名:%@",model.name];
    
    _timeLabel.text = [NSString stringWithFormat:@"时间:%ld秒",model.time];
}

- (void)setRanking:(NSInteger)ranking {
    _ranking = ranking;
    
    _rankingLabel.text = [NSString stringWithFormat:@"%ld",ranking];
}

@end
