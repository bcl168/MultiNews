//
//  HeadlinesTableViewController.m
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import "HeadlinesTableViewController.h"

@interface HeadlinesTableViewController ()

@end

@implementation HeadlinesTableViewController
{
    NSMutableArray *_articles;
    NewsFeed *_newsfeed;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _newsfeed = [[NewsFeed alloc]init];
    
    _newsfeed.delegate = self;
    [_newsfeed getArticles:self.newsSource];
    
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
    
    cell.articleImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.articleImage.layer.masksToBounds=YES;
    
    // Configure the cell...
    if (article.imageData == nil)
        {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                       ^{
                           NSURL *imageURL = [NSURL URLWithString:article.imageURL];
                           NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                           
                           //This is your completion handler
                           dispatch_sync(dispatch_get_main_queue(),
                                         ^{
                                             article.imageData = imageData;
                                             cell.articleImage.image = [[UIImage alloc] initWithData:article.imageData];
                                         });
                           
                           
                       });
        }
    else
        cell.articleImage.image = [UIImage imageWithData:article.imageData];
    
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

