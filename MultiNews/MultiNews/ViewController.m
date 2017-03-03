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
    
    _newsSourceNames = @[@"Associated Press", @"BBC News", @"CNBC", @"CNN", @"Google News", @"IGN", @"Mirror", @"Recode", @"TechCrunch", @"TechRadar"];
    _newsSourceIds = @[@"associated-press", @"bbc-news", @"cnbc", @"cnn", @"google-news", @"ign", @"mirror", @"recode", @"techcrunch", @"techradar"];
    self.newsPickerView.dataSource = self;
    self.newsPickerView.delegate = self;

    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    _newsSourceIndex = [[NSUserDefaults standardUserDefaults]integerForKey:@"LastSelected"];
    [self.newsPickerView selectRow:_newsSourceIndex inComponent:0 animated:NO];
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
    controller.title = [NSString stringWithFormat:@"%@ Top Stories",_newsSourceNames[_newsSourceIndex]];
}

@end
