//
//  LGCategoryView.m
//  titleScroll
//
//  Created by gujianming on 7/14/15.
//  Copyright (c) 2015 jamy. All rights reserved.
//

#import "LGCategoryView.h"

static NSString *const cellIdentifier = @"speraterCell";

@interface LGCategoryView () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@end

@implementation LGCategoryView
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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.minimumLineSpacing = 1;
    flowLayout.minimumInteritemSpacing = 1;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollEnabled = YES;
    collection.bounces = YES;
    collection.backgroundColor = [UIColor clearColor];
    collection.showsHorizontalScrollIndicator = NO;
    collection.showsVerticalScrollIndicator = YES;
    
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:collection];
    self.flowLayout = flowLayout;
    self.collection = collection;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.collection.frame = self.bounds;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(70, 44);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];

    UIView *speratorView = [cell.contentView viewWithTag:100];
    [speratorView removeFromSuperview];
    speratorView = nil;
    if (!speratorView) {
        speratorView = [[UIView alloc] init];
        speratorView.frame = CGRectMake(2, cell.frame.size.height -0.6, cell.frame.size.width-4, 0.6);
        speratorView.backgroundColor = [UIColor grayColor];
        speratorView.tag = 100;
        speratorView.alpha = 0.4;
        [cell.contentView addSubview:speratorView];
    }
    
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    [titleLabel setText:@""];
    [titleLabel removeFromSuperview];
    titleLabel = nil;
    if (!titleLabel) {
        titleLabel = [[UILabel alloc] init];
        titleLabel.frame = CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height - 4);
        titleLabel.font = [UIFont systemFontOfSize:12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.tag = 101;
        [cell.contentView addSubview:titleLabel];
    }
    
    titleLabel.text = self.titles[indexPath.row];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    if (titleLabel) {
        [titleLabel setTextColor:[UIColor redColor]];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(LGCategoryView:didSelectedItem:)]) {
        [self.delegate LGCategoryView:self didSelectedItem:(int)indexPath.row];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *titleLabel = (UILabel *)[cell.contentView viewWithTag:101];
    if (titleLabel) {
        [titleLabel setTextColor:[UIColor blackColor]];
    }
}

@end
