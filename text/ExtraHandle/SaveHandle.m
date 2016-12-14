//
//  SaveHandle.m
//  text
//
//  Created by hanlu on 16/8/4.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "SaveHandle.h"

#import <FMDB.h>

@interface SaveHandle ()

@property (nonatomic,strong) FMDatabase *fmdb;

@property (nonatomic,copy) NSString *dataPath;

@end

@implementation SaveHandle
static SaveHandle *shareSaveHandle = nil;

+ (SaveHandle *)shareSaveHandle {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSaveHandle = [[self alloc] init];
    });
    return shareSaveHandle;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!shareSaveHandle) {
        return [super allocWithZone:zone];
    }
    return nil;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _dataPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"UserInfo.sqlite"];
        
        NSLog(@"%@",_dataPath);
        
        _fmdb = [FMDatabase databaseWithPath:_dataPath];
        
        [_fmdb open];
        
        [self creatTable];
    }
    return self;
}

- (void)creatTable {
    [_fmdb executeUpdate:@"create table if not exists UserTime (ID integer primary key autoincrement not null,name text,time integer,difficulty integer,randomNum integer)"];
}

- (void)saveWithUsrName:(NSString *)usrName andUserTime:(NSInteger)userTime andDifficulty:(KindOfUserDifficulty)difficulty RandomNum:(NSInteger)randomNum{
    [_fmdb executeUpdate:@"insert into UserTime (name,time,difficulty,randomNum) values (?,?,?,?)",usrName,@(userTime),@(difficulty),@(randomNum)];
}

- (NSArray <__kindof UserModel *> *)findModelWithDifficulty:(KindOfUserDifficulty)difficulty {
    FMResultSet *set = [_fmdb executeQuery:@"select * from UserTime where difficulty = ? order by time asc",@(difficulty)];
    
    NSMutableArray *array = [NSMutableArray array];
    
    while ([set next]) {
        NSString *name = [set stringForColumn:@"name"];
        
        NSInteger time = [set intForColumn:@"time"];
        
        NSInteger id_vierfy = [set intForColumn:@"ID"];
        
        NSInteger randomNum = [set intForColumn:@"randomNum"];
        
        KindOfUserDifficulty difficulty = [set intForColumn:@"difficulty"];
        
        [array addObject:[UserModel modelWithName:name Time:time ID:id_vierfy Difficulty:difficulty RandomNum:randomNum]];
    }
    
    return array;
}

- (void)deleteWithID:(NSInteger)ID {
    [_fmdb executeUpdate:@"delete from UserTime where ID = ?",@(ID)];
}

@end
