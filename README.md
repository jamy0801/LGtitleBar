# LGtitleBar
UICollectionView 仿导航栏滑动效果UISegmentedControl

## LGTitleBar是一款横向的滚动式选择列表视图，可以用于代替Segement,支持delegate和dataSource方法。是目前开发经常都会用到的一种视图方式
  基于UICollectionView开发，效果很好，使用也非常的方便；
  示例：
  
  ![](https://github.com/jamy0801/LGtitleBar/blob/master/gif/demo.gif)
  
## 使用方法

  将LGTitleBar里面的4个文件拖入到您的工程中就可以使用啦：

    LGtitleBarView *titleBar = [[LGtitleBarView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 45)];
    self.titles = @[@"我的商城", @"我的优惠券", @"团购券", @"积分商城", @"微信", @"微博", @"墨迹天气"];
    titleBar.titles = self.titles;
    titleBar.delegate = self;
    [self.view addSubview:titleBar];
    
### 然后实现代理方法：

    -(void)LGtitleBarView:(LGtitleBarView *)titleBarView didSelectedItem:(int)index
     {
      NSLog(@"%d", index);
     // 以下代码为我测试用的
      NSString *str = [NSString stringWithFormat:@"http://www.baidu.com/s?wd=%@", self.titles[index]];
      str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      NSURL *url = [NSURL URLWithString:str];
      NSURLRequest *request = [NSURLRequest requestWithURL:url];
      [self.webView loadRequest:request];
     }
