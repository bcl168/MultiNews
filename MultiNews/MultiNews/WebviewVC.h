//
//  WebviewVC.h
//  MultiNews
//
//  Created by George E. Correa on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface WebviewVC : UIViewController<WKNavigationDelegate>

@property (strong, nonatomic) NSURL *url;

@end
