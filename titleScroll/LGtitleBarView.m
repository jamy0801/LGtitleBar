//
//  LGtitleBarView.m
//  titleScroll
//
//  Created by jamy on 15/7/6.
//  Copyright (c) 2015年 jamy. All rights reserved.
//

#import "LGtitleBarView.h"
#import "LGcollectionCell.h"

#define KCollectionCellHeight 39
#define LCollectionCellMargin 20


static NSString *const cellIdentifier = @"cells";

@interface LGtitleBarView ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collection;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) UIView *bottomView;
@end

@implementation LGtitleBarView

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
    
    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    collection.dataSource = self;
    collection.delegate = self;
    collection.scrollEnabled = YES;
    collection.bounces = NO;
    collection.backgroundColor = [UIColor clearColor];
    collection.showsHorizontalScrollIndicator = NO;
    collection.showsVerticalScrollIndicator = NO;
    
    [collection registerClass:[LGcollectionCell class] forCellWithReuseIdentifier:cellIdentifier];
    [self addSubview:collection];
    self.flowLayout = flowLayout;
    self.collection = collection;
    
    UIView *bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor redColor];
    [self.collection addSubview:bottomView];
    self.bottomView = bottomView;
}

-(void)setTitles:(NSArray *)titles
{
    _titles = titles;
    self.collection.frame = self.bounds;
    self.bottomView.frame = CGRectMake(2, KCollectionCellHeight - 2, [self sizeForTitle:self.titles[0]] - 4, 2);
    [self.collection reloadData];
}

- (CGFloat)sizeForTitle:(NSString *)title
{
    return [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}].width+LCollectionCellMargin;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = [self sizeForTitle:self.titles[indexPath.row]];
    return CGSizeMake(width, KCollectionCellHeight);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGcollectionCell *cell = (LGcollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell setTitleName:self.titles[indexPath.row]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    LGcollectionCell *cell = (LGcollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    [UIView animateWithDuration:0.25 animations:^{
        self.bottomView.frame = CGRectMake(cell.frame.origin.x, cell.frame.size.height-2, cell.frame.size.width - 4, 2);
    }];
    if(self.delegate && [self.delegate respondsToSelector:@selector(LGtitleBarView:didSelectedItem:)])
    {
        [self.delegate LGtitleBarView:self didSelectedItem:(int)indexPath.row];
    }
}



@end
