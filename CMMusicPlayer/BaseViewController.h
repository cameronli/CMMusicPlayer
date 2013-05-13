//
//  BaseViewController.h
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-12.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@class AppDelegate;
@interface BaseViewController : UIViewController



- (AppDelegate *)appMain;

- (AVAudioPlayer *)player;

- (void)setPlayer:(AVAudioPlayer *)player;

- (NSString *)currentSongName;

- (void)setCurrentSongName:(NSString *)currentSongName;

@end
