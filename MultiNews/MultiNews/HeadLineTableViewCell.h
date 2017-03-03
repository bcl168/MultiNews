//
//  HeadLineTableViewCell.h
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadLineTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *headline;
@property (weak, nonatomic) IBOutlet UILabel *summary;


@end
