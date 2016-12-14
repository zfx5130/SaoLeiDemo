//
//  Position.m
//  text
//
//  Created by hanlu on 16/8/2.
//  Copyright © 2016年 吴迪. All rights reserved.
//

#import "Position.h"

@implementation Position

- (instancetype)initWithX:(NSInteger)x andY:(NSInteger)y
{
    self = [super init];
    if (self) {
        _x = x;
        
        _y = y;
    }
    return self;
}

+ (instancetype)positionWithX:(NSInteger)x andY:(NSInteger)y {
    return [[self alloc] initWithX:x andY:y];
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        Position *obj = object;
        
        if (obj.x == self.x && obj.y == self.y) {
            return YES;
        }
    }
    
    return NO;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"x:%ld y:%ld",self.x,self.y];
}

@end
