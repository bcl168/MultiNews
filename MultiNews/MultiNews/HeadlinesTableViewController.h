//
//  HeadlinesTableViewController.h
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeadLineTableViewCell.h"
#import "Article.h"
#import "NewsFeed.h"

@interface HeadlinesTableViewController : UITableViewController <NewsFeedDelegate>
@property (nonatomic, strong) NSString *newsSource;
@property (nonatomic, strong) NSString *newsSourceTitle;

@end
