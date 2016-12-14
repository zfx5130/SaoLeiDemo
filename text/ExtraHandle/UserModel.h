//
//  UserModel.h
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,KindOfUserDifficulty) {
    KindOfUserDifficultyEasy,
    KindOfUserDifficultyNormal
};

@interface UserModel : NSObject

@property (nonatomic,strong) NSString *name;

@property (nonatomic,assign) NSInteger time;

@property (nonatomic,assign) NSInteger id_vierfy;

@property (nonatomic,assign) NSInteger randomNum;

@property (nonatomic,assign) KindOfUserDifficulty difficulty;

+ (UserModel *)modelWithName:(NSString *)name Time:(NSInteger)time ID:(NSInteger)ID Difficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum;

@end
