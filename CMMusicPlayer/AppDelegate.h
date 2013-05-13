//
//  AppDelegate.h
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-11.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@class MusicPlayViewController;
@class LRCShowViewController;
@class AboutViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) MusicPlayViewController *musicPlayerViewController;

@property (strong, nonatomic) LRCShowViewController *lrcShowViewController;

@property (strong, nonatomic) AboutViewController *aboutViewController;

@property (strong, nonatomic) AVAudioPlayer *player;

@property (strong, nonatomic) NSString *currentSongName;

@end
