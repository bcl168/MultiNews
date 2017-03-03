//
//  HeadlinesTableViewController.m
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import "HeadlinesTableViewController.h"
#import "Headline.h"
#import "NewsFeed.h"
#import "Article.h"

@interface HeadlinesTableViewController ()

@end

@implementation HeadlinesTableViewController
{
    NSMutableArray *_articles;
    NewsFeed *_newsfeed;
    NSURLSession *_session;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _newsfeed = [[NewsFeed alloc]init];
    
    _newsfeed.delegate = self;
    [_newsfeed getArticles:@"cnn"];
    
    NSURLSessionConfiguration *defaultConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
    _session = [NSURLSession sessionWithConfiguration:defaultConfiguration delegate:nil delegateQueue:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
}

- (void) didGetArticles:(NSMutableArray *)articles
{
    _articles = articles;
    [self.tableView reloadData];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _articles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HeadLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    Article *article = [_articles objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    NSLog(@"article.imageURL: %@",article.imageURL);
    
    if (article.imageData == nil) {

        NSURL *imgURL = [NSURL URLWithString:article.imageURL];
        NSURLSessionDataTask *task = [_session dataTaskWithURL:imgURL
                                      completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                            article.imageData = data;
                                      cell.articleImage.image = [[UIImage alloc] initWithData:article.imageData];
                                      }];
        
        [task resume];
        //        [NSURLSession  sendAsynchronousRequest:[NSURLRequest requestWithURL:imgURL] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        //            if (!connectionError) {
                // pass the img to your imageview
                //                cell.articleImage.image = [[UIImage alloc] initWithData:data];
                
        //            }else{
        //      NSLog(@"%@",connectionError);
        //   }
        // }];
    }
    else
           cell.articleImage.image = [UIImage imageWithData:article.imageData];
    
//    cell.articleImage.image = ;
    cell.headline.text = article.headlines;
    cell.summary.text = article.blurb;
    
    return cell;
}





/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//-(void) initArray
//{
//    self.array = [[NSMutableArray alloc] init];
//    
//    Headline *headline1 = [[Headline alloc]init];
//    headline1.imageName = [UIImage imageNamed:@"pic1.jpg"];
//    headline1.headline = @"The Woolly Mammoth’s Last Stand";
//    headline1.summary = @"A new study shows how an endangered or declining species may result in an irreversible genetic meltdown.";
//    [self.array addObject: headline1];
//    
//    Headline *headline2 = [[Headline alloc]init];
//    headline2.imageName = [UIImage imageNamed:@"pic2.jpg"];
//    headline2.headline = @"Scientists Say Canadian Bacteria Fossils May Be Earth’s Oldest";
//    headline2.summary = @"Ancient rocks have yielded tiny fossil-like formations up to 4.2 billion years old, researchers reported. But some experts are skeptical.";
//    [self.array addObject: headline2];
//    
//    Headline *headline3 = [[Headline alloc]init];
//    headline3.imageName = [UIImage imageNamed:@"pic3.jpg"];
//    headline3.headline = @"You’re a Bee. This Is What It Feels Like.";
//    headline3.summary = @"Set your meetings, phone calls and emails aside, at least for the next several minutes. That’s because today you’re a bee.";
//    [self.array addObject: headline3];
//    
//    Headline *headline4 = [[Headline alloc]init];
//    headline4.imageName = [UIImage imageNamed:@"pic4.jpg"];
//    headline4.headline = @"Lake Berryessa’s Spiraling Floodwater Mesmerizes the Locals";
//    headline4.summary = @"There is a mysterious hole in Lake Berryessa in California. It is not a supernatural whirlpool, a demon’s mouth, or a portal into hell or a fourth dimension. The creepy thing probably won’t suck you into it either.";
//    [self.array addObject: headline4];
//}


//========
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
//                       ^{
//                           NSURL *imageURL = [NSURL URLWithString:article.imageURL];
//                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
//
//                           //This is your completion handler
//                           dispatch_sync(dispatch_get_main_queue(), ^{
//                               article.imageData = imageData;
//                               //This needs to be set here now that the image is downloaded
//                               // and you are back on the main thread
//                               cell.articleImage.image = [UIImage imageWithData:article.imageData];
//
//                           });
//                       });
