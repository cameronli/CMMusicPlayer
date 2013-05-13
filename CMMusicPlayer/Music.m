//
//  Music.m
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-12.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "Music.h"

@implementation Music

- (id)initWithName:(NSString *)name type:(NSString *)type
{
    self = [super init];
    if (self) {
        self.name = name;
        self.type = type;
    }
    return self;
}



@end
