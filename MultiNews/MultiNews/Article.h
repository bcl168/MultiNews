//
//  Article.h
//  NewsTest
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Article : NSObject

@property (nonatomic, weak) NSString *headlines;
@property (nonatomic, weak) NSString *blurb;
@property (nonatomic, weak) NSString *articleURL;
@property (nonatomic, weak) NSString *imageURL;

@end
