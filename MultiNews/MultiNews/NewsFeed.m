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
- (void) getArticles:(NSString *) newsSourceName
{
    //
    // sortBy
    //  top         Requests a list of the source's headlines sorted in the order they appear on its homepage.
    //  latest      Requests a list of the source's headlines sorted in chronological order, newest first.
    //  popular     Requests a list of the source's current most popular or currently trending headlines.
    //
    NSString *string = [[NSString alloc] initWithFormat:@"https://newsapi.org/v1/articles?source=%@&sortBy=popular&apiKey={%@}", newsSourceName, API_KEY];
    NSURL *URL = [NSURL URLWithString:string];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse * response, NSError * error)
                                    {
                                        NSDictionary *newsData = [NSJSONSerialization JSONObjectWithData:data
                                                                                                   options:kNilOptions
                                                                                                     error:nil];
                                        dispatch_async(dispatch_get_main_queue(),
                                                       ^{
                                                           [self.delegate didGetArticles:[self parseNewsData:newsData]];
                                                       });
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
