//
//  HeadlinesTableViewController.m
//  NewsHackathon
//
//  Created by Emiko Clark on 3/2/17.
//  Copyright © 2017 Emiko Clark. All rights reserved.
//

#import "HeadlinesTableViewController.h"
#import "DetailViewController.h"
#define  darkBlueColor colorWithRed:20/255.0f green:50/255.0f blue:135/255.0f alpha:1.0

@interface HeadlinesTableViewController ()

@end

@implementation HeadlinesTableViewController
{
    NSMutableArray *_articles;
    NewsFeed *_newsfeed;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set font and color for navigation title
    NSArray *keys = [NSArray arrayWithObjects: NSForegroundColorAttributeName, NSFontAttributeName, nil];
    NSArray *objs = [NSArray arrayWithObjects: [UIColor darkGrayColor], [UIFont fontWithName:@"Palatino" size:20.0f], nil];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjects:objs forKeys:keys];
    
    _newsfeed = [[NewsFeed alloc] init];
    _newsfeed.delegate = self;
    [_newsfeed getArticlesFrom:self.newsSource];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerNib:[UINib nibWithNibName:@"HeadLineTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NewsFeed Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by NewsFeed when it has successfully retrieved news articles.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didGetArticles:(NSMutableArray *)articles
{
    _articles = articles;
    [self.tableView reloadData];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by NewsFeed when it failed to retrieve news articles.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didGetNewsFeedError:(NSString *) errorMsg
{
    // Initialize the controller for displaying the message
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@" "
                                                                   message:errorMsg
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    // Create an OK button
    UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:nil];
    
    // Add the button to the controller
    [alert addAction:okButton];
    
    // Display the alert controller
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - UITableView Data Source Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of section in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method to specify the number of rows in the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _articles.count;
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method for loading data into current row of the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Get a recycled table row
    HeadLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    
    // set font and color for navigation title
    cell.headline.font = [UIFont fontWithName:@"Palatino" size:20.0f];
    cell.headline.textColor = [UIColor darkBlueColor];

    Article *article = [_articles objectAtIndex:indexPath.row];
    
    cell.articleImage.contentMode = UIViewContentModeScaleAspectFill;
    cell.articleImage.layer.masksToBounds=YES;
    
    // If the news source supplies an image and ...
    if ([article.imageURL isKindOfClass:[NSString class]])
    {
        // If we haven't loaded the image yet then ...
        if (article.imageData == nil)
        {
            // load the image in the background.
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),
                           ^{
                               NSURL *imageURL = [NSURL URLWithString:article.imageURL];
                               NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
                               
                               dispatch_sync(dispatch_get_main_queue(),
                                             ^{
                                                 // display the image and ...
                                                 cell.articleImage.image = [[UIImage alloc] initWithData:imageData];
                                                 // "cache" it
                                                 article.imageData = imageData;
                                             });
                           });
        }
        // Otherwise, ...
        else
            // display the "cached" image
            cell.articleImage.image = [UIImage imageWithData:article.imageData];
    }
    else
        // imageURL not provided by news source so, put placeholder image
        cell.articleImage.image = [UIImage imageNamed:@"news.jpg"];

    cell.headline.text = article.headlines;
    cell.summary.text = article.blurb;
    
    return cell;
}

#pragma mark - UITableView Delegate Methods

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method that is called when the user select a row on the tableView.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Article *article = [_articles objectAtIndex:indexPath.row];
    
    // Initialize the DetailViewController
    DetailViewController *controller = [[DetailViewController alloc] init];
    controller.url = [NSURL URLWithString:article.articleURL];
    controller.title = self.newsSourceTitle;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    // Display the DetailViewController.
    [self.navigationController pushViewController:controller animated:YES];
}

@end

