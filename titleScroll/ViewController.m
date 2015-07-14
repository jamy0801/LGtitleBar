//
//  ViewController.m
//  titleScroll
//
//  Created by jamy on 15/7/4.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import "ViewController.h"
#import "LGtitleBarView.h"
#import "LGCategoryView.h"

@interface ViewController () <LGtitleBarViewDelegate, LGCategoryViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *webViewConstraint;

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *categoryTitles;

@property (nonatomic, strong) LGtitleBarView *titleBar;
@property (nonatomic, strong) LGCategoryView *category;
@end

#define KCollectionCellHeight 39
static NSString *const cellIdentifier = @"cells";

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addTitleBars];
}




#pragma mark 横向列表

- (void)addTitleBars
{
    LGtitleBarView *titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
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






#pragma mark 纵向分类显示

- (void)addCategroyView
{
    LGCategoryView *category = [[LGCategoryView alloc] initWithFrame:CGRectMake(0, 110, 70, self.view.frame.size.height - 150)];
    category.titles = @[@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气",@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气"];
    [self.view addSubview:category];
    category.delegate = self;
    self.categoryTitles = category.titles;
    self.category = category;
}


-(void)LGCategoryView:(LGCategoryView *)categoryView didSelectedItem:(int)index
{
    NSLog(@"%d", index);
    
    NSString *str = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@", self.categoryTitles[index]];
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
}



#pragma mark -添加导航栏

- (void)addNavgationBar
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"纵向分类" style:UIBarButtonItemStyleDone target:self action:@selector(showCategroyView)];
    
    self.navigationItem.rightBarButtonItem = item;
}

- (void)showCategroyView
{
    if (self.category) {
        [UIView animateWithDuration:0.4 animations:^{
            [self.category removeFromSuperview];
            self.category = nil;
        }];
    }
    else
    {
        [self addCategroyView];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self addNavgationBar];
}

@end
