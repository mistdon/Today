//
//  DXCollectionComponent.h
//  ejc
//
//  Created by shendong on 2017/10/23.
//  Copyright © 2017年 Shanghai Elephant Financial Services Co., Ltd. All rights reserved.
//

#import "DXBaseTableComponent.h"

@interface DXCollectionComponent : DXBaseTableComponent<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, readonly) UICollectionView *collectionView;

- (void)configureCollectionView:(UICollectionView *)collectionView NS_REQUIRES_SUPER;

- (CGRect)collectionViewRectForBounds:(CGRect)bounds;

@end
