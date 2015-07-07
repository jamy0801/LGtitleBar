//
//  LGcollectionCell.m
//  titleScroll
//
//  Created by jamy on 15/7/4.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import "LGcollectionCell.h"

@interface LGcollectionCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation LGcollectionCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    return self;
}

- (void)setUp
{
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor blackColor];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [self addSubview:titleLabel];
    self.titleLabel = titleLabel;
    
    UIView *selectView = [[UIView alloc] init];
    selectView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.selectedBackgroundView = selectView;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    self.titleLabel.frame = CGRectMake(0, 0, width, height*0.9);
}

-(void)setTitleName:(NSString *)titleName
{
    if (self.titleName != titleName) {
        _titleName = titleName;
        [_titleLabel setText:titleName];
    }
}

@end
