//
//  ViewController.m
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-11.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "MusicPlayViewController.h"

@interface MusicPlayViewController ()

@end

@implementation MusicPlayViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"音乐播放";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"interest_icon_music"] tag:101];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isPlay = YES;
    [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(showCurrentTime:) userInfo:nil repeats:YES];
    [self showLocalMusic];
    [self initData];
}

- (void)initData
{
//    Music *music1 = [[Music alloc] initWithName:@"美丽与勇敢" type:@"mp3"];
//    musicArray = [[NSMutableArray alloc] initWithObjects:music1, nil];
    
//	self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:music1.name ofType:music1.type]] error:nil];
    MPMediaItem *item = [musicArray objectAtIndex:0];
    NSURL *url = (NSURL *)[item valueForProperty:MPMediaItemPropertyAssetURL];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
   
}

#pragma mark -
#pragma mark action

- (IBAction)preSong:(id)sender {
    int selectedIndex = [self.songList indexPathForSelectedRow].row;
    NSIndexPath *index = nil;
    if (selectedIndex == 0) {
        index = [NSIndexPath indexPathForItem:[musicArray count]-1 inSection:0];
    } else {
        index = [NSIndexPath indexPathForItem:selectedIndex-1 inSection:0];
    }
    [self.songList selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.songList didSelectRowAtIndexPath:index];
    [self.songList scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (IBAction)nextSong:(id)sender {
    int selectedIndex = [self.songList indexPathForSelectedRow].row;
    NSIndexPath *index = nil;
    if (selectedIndex == [musicArray count]-1) {
        index = [NSIndexPath indexPathForItem:0 inSection:0];
    } else {
        index = [NSIndexPath indexPathForItem:selectedIndex+1 inSection:0];
    }
    [self.songList selectRowAtIndexPath:index animated:YES scrollPosition:UITableViewScrollPositionNone];
    [self tableView:self.songList didSelectRowAtIndexPath:index];
    [self.songList scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionNone animated:YES];
}

- (IBAction)playOrParse:(UIButton *)sender {
    if (isPlay) {
        [self.player play];
        self.currentSongName = [self.songList cellForRowAtIndexPath:[self.songList indexPathForSelectedRow]].textLabel.text;
        [sender setImage:[UIImage imageNamed:@"Pause"] forState:UIControlStateNormal];
        isPlay = NO;
    } else {
        [self.player stop];
        [sender setImage:[UIImage imageNamed:@"Player"] forState:UIControlStateNormal];
        isPlay = YES;
    }
    self.totalTime.text = [NSString stringWithFormat:@"%d:%d",(int)self.player.duration/60,(int)self.player.duration%60];
}

- (IBAction)sliderControl:(UISlider *)sender {
    self.player.currentTime = self.player.duration * sender.value;
}

- (void)showCurrentTime:(NSTimer *)timer
{
    if ((int)self.player.currentTime%60 < 10) {
        self.currentTime.text = [NSString stringWithFormat:@"%d:0%d",(int)self.player.currentTime/60,(int)self.player.currentTime%60];
    } else {
        self.currentTime.text = [NSString stringWithFormat:@"%d:%d",(int)self.player.currentTime/60,(int)self.player.currentTime%60];    }
    self.timeSlider.value = self.player.currentTime/self.player.duration;
}

- (void)showLocalMusic
{
    MPMediaQuery *myPlaylistsQuery = [MPMediaQuery songsQuery];
    musicArray = [NSMutableArray arrayWithArray:[myPlaylistsQuery items]];
    
    [self.songList reloadData];
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.songList selectRowAtIndexPath:index animated:NO scrollPosition:UITableViewScrollPositionNone];
}

#pragma mark - 
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [musicArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItem *item = [musicArray objectAtIndex:indexPath.row];
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = (NSString *)[item valueForProperty:MPMediaItemPropertyTitle];
    return cell;
}

#pragma mark -
#pragma UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MPMediaItem *item = [musicArray objectAtIndex:indexPath.row];
    NSURL *url = (NSURL *)[item valueForProperty:MPMediaItemPropertyAssetURL];
    [self.player stop];
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    isPlay = YES;
    [self playOrParse:self.playOrPauseBtn];
    
}

@end
