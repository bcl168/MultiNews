//
//  Article.h
//  NewsTest
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface Article : NSObject

@property (nonatomic, strong) NSString *headlines;
@property (nonatomic, strong) NSString *blurb;
@property (nonatomic, strong) NSString *articleURL;
@property (nonatomic, strong) NSString *imageURL;

@end
