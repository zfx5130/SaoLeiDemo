//
//  SaveHandle.h
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface SaveHandle : NSObject

+ (SaveHandle *)shareSaveHandle;

- (void)creatTable;

- (void)saveWithUsrName:(NSString *)usrName andUserTime:(NSInteger)userTime andDifficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum;

- (NSArray <__kindof UserModel *> *)findModelWithDifficulty:(KindOfUserDifficulty)difficulty;

- (void)deleteWithID:(NSInteger)ID;

@end
