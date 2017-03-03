//
//  DetailViewController.m
//  MultiNews
//
//  Created by George E. Correa on 3/2/17.
//  Copyright © 2017 bl. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *returnToMain = [[UIBarButtonItem alloc] initWithTitle:@"Main Menu" style:UIBarButtonItemStylePlain target:self action:@selector(returnToMainMenu)];
    self.navigationItem.rightBarButtonItem = returnToMain;
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:[[UIScreen mainScreen]bounds] configuration:configuration];
    webView.navigationDelegate = self;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    [self.view addSubview:webView];
}

- (void)returnToMainMenu {
    NSMutableArray *allViewControllers = [NSMutableArray arrayWithArray:[self.navigationController viewControllers]];
    for (UIViewController *aViewController in allViewControllers) {
        if ([aViewController isKindOfClass:[ViewController class]]) {
            [self.navigationController popToViewController:aViewController animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
