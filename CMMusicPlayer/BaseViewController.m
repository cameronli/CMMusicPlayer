//
//  BaseViewController.m
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-12.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (AppDelegate *)appMain
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (AVAudioPlayer *)player
{
    return [self appMain].player;
}

- (void)setPlayer:(AVAudioPlayer *)player
{
    [[self appMain] setPlayer:player];
}

- (NSString *)currentSongName
{
    return [self appMain].currentSongName;
}

- (void)setCurrentSongName:(NSString *)currentSongName
{
    [[self appMain] setCurrentSongName:currentSongName];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
