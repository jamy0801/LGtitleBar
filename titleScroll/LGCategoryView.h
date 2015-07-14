//
//  LGCategoryView.h
//  titleScroll
//
//  Created by gujianming on 7/14/15.
//  Copyright (c) 2015 jamy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LGCategoryView;
@protocol LGCategoryViewDelegate <NSObject>
@optional
- (void)LGCategoryView:(LGCategoryView *)categoryView didSelectedItem:(int)index;

@end

@interface LGCategoryView : UIView
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic,assign) id<LGCategoryViewDelegate> delegate;
@end
