//
//  NewsFeed.m
//  NewsTest
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import "NewsFeed.h"
#import "SecretKey.h"
#import "Article.h"


@implementation NewsFeed

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to asynchronously request news data.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) getArticlesFrom:(NSString *)newsSourceName
{
    NSString *string = [[NSString alloc] initWithFormat:@"https://newsapi.org/v1/articles?source=%@&sortBy=top&apiKey=%@", newsSourceName, API_KEY];
    NSURL *URL = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                {
                    if (error)
                    {
                        dispatch_async(dispatch_get_main_queue(),
                                       ^{
                                           [self.delegate didGetNewsFeedError:[error localizedDescription]];
                                       });
                    }
                    else
                    {
                        NSDictionary *newsData = [NSJSONSerialization JSONObjectWithData:data
                                                                                 options:kNilOptions
                                                                                   error:nil];
                        dispatch_async(dispatch_get_main_queue(),
                         ^{
                             [self.delegate didGetArticles:[self parseNewsData:newsData]];
                         });
                    }
                }] resume];
}

#pragma mark - Private Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to parse the returned data into an array of articles.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *) parseNewsData:(NSDictionary *)newsData
{
    NSArray *newsArticleArray = newsData[@"articles"];
    NSMutableArray *articles = [[NSMutableArray alloc] init];
    
    for (NSDictionary *articleData in newsArticleArray)
    {
        Article *article = [[Article alloc] init];

        article.headlines = articleData[@"title"];
        article.blurb = articleData[@"description"];
        article.articleURL = articleData[@"url"];
        article.imageURL = articleData[@"urlToImage"];
        
        [articles addObject:article];
    }
    
    return articles;
}

@end
