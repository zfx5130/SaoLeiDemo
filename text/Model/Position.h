//
//  Position.h
//  text
//
//  Created by hanlu on 16/8/2.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Position : NSObject

@property (nonatomic,assign) NSInteger x;

@property (nonatomic,assign) NSInteger y;

+ (instancetype)positionWithX:(NSInteger)x andY:(NSInteger)y;


@end
