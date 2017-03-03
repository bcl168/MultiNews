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


typedef void(^httpGetCompletionHandler)(NSData *, NSURLResponse *, NSError *);

@implementation NewsFeed

#pragma mark - Public Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to asynchronously request news data.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) getArticlesFrom:(NSString *)newsSourceName
{
    NSString *urlString = [[NSString alloc] initWithFormat:@"https://newsapi.org/v1/articles?source=%@&sortBy=top&apiKey=%@", newsSourceName, API_KEY];
    httpGetCompletionHandler articleGetHandler = ^ void (NSData *data, NSURLResponse *response, NSError *error)
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
                               [self.delegate didGetArticles:[self parseNewsArticleData:newsData]];
                           });
        }
    };

    [self executeGetRequest:urlString withCompletionHandler:articleGetHandler];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to asynchronously request list of news source.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) getNewsSources
{
    NSString *urlString = @"https://newsapi.org/v1/sources?language=en";
    httpGetCompletionHandler articleGetHandler = ^ void (NSData *data, NSURLResponse *response, NSError *error)
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
                               NSMutableArray *sourceIds = [[NSMutableArray alloc] init];
                               NSMutableArray *sourceNames = [[NSMutableArray alloc] init];
                               [self parseNewsSourceData:newsData into:sourceNames and:sourceIds];

                               [self.delegate didGetNewsSources:sourceNames and:sourceIds];
                           });
        }
    };
    
    [self executeGetRequest:urlString withCompletionHandler:articleGetHandler];
}

#pragma mark - Private Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to execute http get request.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) executeGetRequest:(NSString *)urlString withCompletionHandler:httpGetCompletionHandler
{
    NSURL *URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    request.HTTPMethod = @"GET";
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:httpGetCompletionHandler] resume];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to parse the returned data into an array of articles.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray *) parseNewsArticleData:(NSDictionary *)newsArticleData
{
    NSArray *newsArticleArray = newsArticleData[@"articles"];
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

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Method to parse the returned data into a parallel array of names and id.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) parseNewsSourceData:(NSDictionary *)newsSourceData
                        into:(NSMutableArray *)sourceNames
                         and:(NSMutableArray *)sourceIds
{
    NSMutableArray *newsSourceArray = newsSourceData[@"sources"];
    
    for (NSDictionary *sourceData in newsSourceArray)
    {
        [sourceIds addObject:sourceData[@"id"]];
        [sourceNames addObject:sourceData[@"name"]];
    }
}

@end
