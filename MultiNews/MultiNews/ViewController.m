//
//  ViewController.m
//  MultiNews
//
//  Created by bl on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.newsData = @[@"cnn", @"fox"];
    self.newsPickerView.dataSource = self;
    self.newsPickerView.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    NSInteger lastSelected = [[NSUserDefaults standardUserDefaults]integerForKey:@"LastSelected"];
    [self.newsPickerView selectRow:lastSelected inComponent:0 animated:NO];
    
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.newsData.count;
}

- (NSString*)pickerView:(UIPickerView *)zones titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    return self.newsData[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"LastSelected"];
    
    //set last selected pickerview index in userdefaults
    
    [[NSUserDefaults standardUserDefaults]setInteger:row forKey:@"LastSelected"];
    
    //set timezone in userdefaults
    
    if([self.newsData[row]  isEqual: @"cnn"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"EDT" forKey:@"timeZone"];
        
    }
    if([self.newsData[row]  isEqual: @"fox"]){
        [[NSUserDefaults standardUserDefaults] setObject:@"CDT" forKey:@"timeZone"];
        
    }
    
    
    
}


@end
