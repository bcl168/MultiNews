//
//  Headline.h
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Headline : NSObject
@property (nonatomic, strong) UIImage *imageName;
@property (nonatomic, strong) NSString *headline;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *url;

@end
