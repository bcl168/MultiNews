//
//  NewsFeed.h
//  NewsTest
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import <Foundation/Foundation.h>


@protocol NewsFeedDelegate <NSObject>

- (void) didGetArticles:(NSMutableArray *) articles;

@end


@interface NewsFeed : NSObject

@property (strong, nonatomic) id<NewsFeedDelegate> delegate;

- (void) getArticles:(NSString *) newsSourceName;

@end
