//
//  LRCShowViewController.m
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-11.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "LRCShowViewController.h"

@interface LRCShowViewController ()

@end

@implementation LRCShowViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"歌词";
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:self.title image:[UIImage imageNamed:@"interest_icon_lrc"] tag:201];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [NSTimer scheduledTimerWithTimeInterval:0.01f target:self selector:@selector(disPlaySongWord:) userInfo:nil repeats:YES];
//    NSString *musicName = self.player.url;
//    NSString *lrcStr = [[NSBundle mainBundle] ]
}

- (void)viewWillAppear:(BOOL)animated
{
    currentIndex = 0;
    [super viewWillAppear:animated];
    timeArray = nil;
    timeArray = [[NSMutableArray alloc] initWithCapacity:10];
    LRCDictionary = nil;
    LRCDictionary = [[NSMutableDictionary alloc] initWithCapacity:10];
    NSString *lrcPath = [[NSBundle mainBundle] pathForResource:self.currentSongName ofType:@"lrc"];
    NSString *lrcContent = [NSString stringWithContentsOfFile:lrcPath encoding:NSUTF8StringEncoding error:nil];
    NSArray *lrcArr = [lrcContent componentsSeparatedByString:@"\n"];
    for (int i = 4; i < [lrcArr count]; i++) {
        NSString *lineStr = [lrcArr objectAtIndex:i];
        NSArray *lineArr = [lineStr componentsSeparatedByString:@"]"];
        if ([[lineArr objectAtIndex:0] length]>5) {
            NSString *lrcStr = [lineArr objectAtIndex:1];
            NSString * timeStr = [[lineArr objectAtIndex:0] substringWithRange:NSMakeRange(1, 5)];
            [timeArray addObject:timeStr];
            [LRCDictionary setObject:lrcStr forKey:timeStr];
        }
    }
    [self.LRCTableView reloadData];
    NSLog(@"%@",lrcContent);
}

#pragma mark - 
#pragma mark action
- (void)disPlaySongWord:(NSTimer *)timer
{
    if ([timeArray count]>0) {
        NSArray *array = [[timeArray objectAtIndex:currentIndex] componentsSeparatedByString:@":"];
        NSInteger currentTime = [[array objectAtIndex:0] intValue]*60 + [[array objectAtIndex:1] intValue];
        if (currentTime < (int)self.player.currentTime) {
            currentIndex ++;
            return;
        }
        if (currentTime == (int)self.player.currentTime) {
            NSLog(@"%d",currentTime);
            [self updateLRCTableView:currentIndex];
            currentIndex++;
        }
    }
}

- (void)updateLRCTableView:(NSUInteger)index
{
    if (index < [timeArray count]) {
        NSLog(@"%@",[LRCDictionary objectForKey:[timeArray objectAtIndex:index]]);
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
        [self.LRCTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
//    [self.LRCTableView sel]
}

#pragma mark -
#pragma mark memory control
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - 
#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [timeArray count];
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    cell.textLabel.text = [LRCDictionary objectForKey:[timeArray objectAtIndex:indexPath.row]];
    return cell;
}

@end
