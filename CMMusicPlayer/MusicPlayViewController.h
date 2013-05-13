//
//  ViewController.h
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-11.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "BaseViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "Music.h"

@interface MusicPlayViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *musicArray;
    BOOL isPlay;
}

//@property (nonatomic, retain) AVAudioPlayer *player;

@property (weak, nonatomic) IBOutlet UITableView *songList;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *totalTime;
@property (weak, nonatomic) IBOutlet UISlider *timeSlider;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;

- (IBAction)preSong:(id)sender;
- (IBAction)nextSong:(id)sender;
- (IBAction)playOrParse:(UIButton *)sender;
- (IBAction)sliderControl:(UISlider *)sender;

@end
