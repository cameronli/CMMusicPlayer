//
//  LRCShowViewController.h
//  CMMusicPlayer
//
//  Created by Cameron on 13-5-11.
//  Copyright (c) 2013年 cm. All rights reserved.
//

#import "BaseViewController.h"

@interface LRCShowViewController : BaseViewController<UITableViewDataSource>
{
    NSMutableArray *timeArray;
    NSMutableDictionary *LRCDictionary;
    int currentIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *LRCTableView;

@end
