//
//  Music.h
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-12.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Music : NSObject
{
    
}

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *type;

- (id)initWithName:(NSString *)name type:(NSString *)type;

@end
