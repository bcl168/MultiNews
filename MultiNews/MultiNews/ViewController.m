//
//  ViewController.m
//  MultiNews
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//


#import "ViewController.h"
#import "HeadlinesTableViewController.h"


@interface ViewController ()

@end


@implementation ViewController
{
    NSArray *_newsSourceNames;
    NSArray *_newsSourceIds;
    NSInteger _newsSourceIndex;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // set font and color for navigation title
    NSArray *keys = [NSArray arrayWithObjects: NSForegroundColorAttributeName, NSFontAttributeName, nil];
    NSArray *objs = [NSArray arrayWithObjects: [UIColor darkGrayColor], [UIFont fontWithName:@"HelveticaNeue" size:20.0f], nil];
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjects:objs forKeys:keys];

    NewsFeed *newsFeed = [[NewsFeed alloc] init];
    newsFeed.delegate = self;
    [newsFeed getNewsSources];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _newsSourceNames.count;
}

- (NSString*)pickerView:(UIPickerView *)zones titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return _newsSourceNames[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"LastSelected"];
    _newsSourceIndex = row;
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    HeadlinesTableViewController *controller = segue.destinationViewController;
    controller.newsSource = _newsSourceIds[_newsSourceIndex];
    controller.newsSourceTitle = _newsSourceNames[_newsSourceIndex];
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
    controller.title = [NSString stringWithFormat:@"%@ Top Stories",_newsSourceNames[_newsSourceIndex]];
}

//////////////////////////////////////////////////////////////////////////////////////////
//
//  Delegate method called by NewsFeed when it retrieved all the news sources.
//
//////////////////////////////////////////////////////////////////////////////////////////
- (void) didGetNewsSources:(NSMutableArray *)sourceNames
                       and:(NSMutableArray *)sourceIds
{
    _newsSourceNames = sourceNames;
    _newsSourceIds = sourceIds;
    
    self.newsPickerView.dataSource = self;
    self.newsPickerView.delegate = self;

    _newsSourceIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"LastSelected"];
    [self.newsPickerView selectRow:_newsSourceIndex inComponent:0 animated:NO];
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

@end
