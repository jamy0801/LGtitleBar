//
//  ViewController.m
//  titleScroll
//
//  Created by jamy on 15/7/4.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import "ViewController.h"
#import "LGtitleBarView.h"

@interface ViewController () <LGtitleBarViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) LGtitleBarView *titleBar;
@end

#define KCollectionCellHeight 39
static NSString *const cellIdentifier = @"cells";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    LGtitleBarView *titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
    self.titles = @[@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气"];
    titleBar.titles = self.titles;
    titleBar.delegate = self;
    [self.view addSubview:titleBar];
}

-(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
{
    NSLog(@"%d", index);
    
    NSString *str = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@", self.titles[index]];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}


-(IBAction)click
{
    
}
@end
