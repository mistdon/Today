//
//  DXCollectionComponent.m
//  ejc
//
//  Created by shendong on 2017/10/23.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import "DXCollectionComponent.h"

@interface DXCollectionComponent()
@property (nonatomic) UICollectionView *collectionView;
@end
@implementation DXCollectionComponent
- (instancetype)initWithTableView:(UITableView *)tableView delegate:(id<DXTableComponentDelegate>)delegate{
    self = [super initWithTableView:tableView delegate:delegate];
    if (self) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        layout.minimumInteritemSpacing = 8.f;
        layout.minimumLineSpacing = 8.f;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self configureCollectionView:self.collectionView];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
    }
    return self;
}
- (void)reloadDataWithTableView:(UITableView *)tableView inSection:(NSInteger)section{
    [self.collectionView reloadData];
}
- (NSInteger)numberOfItems{
    return 1;
}
- (CGFloat)heightForComponentItemAtIndex:(NSUInteger)index{
    return 150.f;
}
- (void)didSelectItemAtIndex:(NSUInteger)index{
    
}
- (__kindof UITableViewCell *)cellForTableView:(UITableView *)tableView atIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.collectionView.frame = [self collectionViewRectForBounds:cell.bounds];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [cell.contentView addSubview:self.collectionView];
    return cell;
}
- (void)configureCollectionView:(UICollectionView *)collectionView{
    collectionView.contentInset = UIEdgeInsetsMake(8, 8, 8, 8);
    collectionView.backgroundColor = [UIColor clearColor];
    collectionView.scrollsToTop = NO;
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
}
- (void)didDisplayCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath{
    self.collectionView.frame = [self collectionViewRectForBounds:cell.contentView.bounds];
}
- (void)didEndDisplayingCell:(__kindof UITableViewCell *)cell forIndexPath:(NSIndexPath *)indexPath{
   
}
#pragma mark - Methods

- (CGRect)collectionViewRectForBounds:(CGRect)bounds{
    return bounds;
}

#pragma mark - UICollection Datasource & Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.delegate && [self.delegate respondsToSelector:@selector(tableComponent:didSelectedAtIndex:)]) {
        [self.delegate tableComponent:self didSelectedAtIndex:indexPath.item];
    }
}
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
