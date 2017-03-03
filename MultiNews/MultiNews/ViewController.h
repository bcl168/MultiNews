//
//  ViewController.h
//  MultiNews
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsFeed.h"

@interface ViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate, NewsFeedDelegate>
@property (strong, nonatomic) IBOutlet UIPickerView *newsPickerView;

@property (strong, nonatomic) NSArray *newsData;

@end

