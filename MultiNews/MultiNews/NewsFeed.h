//
//  NewsFeed.h
//  NewsTest
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol NewsFeedDelegate <NSObject>

- (void) didGetNewsFeedError:(NSString *)errorMsg;

@optional
- (void) didGetArticles:(NSMutableArray *)articles;
- (void) didGetNewsSources:(NSMutableArray *)sourceNames and:(NSMutableArray *)sourceIds;

@end


@interface NewsFeed : NSObject

@property (strong, nonatomic) id<NewsFeedDelegate> delegate;

- (void) getArticlesFrom:(NSString *)newsSourceName;
- (void) getNewsSources;

@end
