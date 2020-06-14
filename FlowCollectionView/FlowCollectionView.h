//
//  FlowCollectionView.h
//  FlowCollectionView
//
//  Created by v on 2020/6/13.
//  Copyright © 2020 lvv. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlowCollectionSupplementaryView.h"
#import "FlowCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface FlowCollectionView : UICollectionView

@property(nonatomic, copy) NSInteger (^numberOfSectionsBlock)(FlowCollectionView *collectionView);

@property(nonatomic, copy) NSInteger (^numberOfItemsInSectionBlock)(FlowCollectionView *collectionView);

@property(nonatomic, copy) __kindof UICollectionViewCell * (^cellForIndexPathBlock)(FlowCollectionView *collectionView, __kindof UICollectionViewCell *(^make)(Class cellClass), NSIndexPath *indexPath);

@property(nonatomic, copy) __kindof UICollectionReusableView * (^headerViewForIndexPathBlock)(FlowCollectionView *collectionView, __kindof UICollectionReusableView *(^make)(Class viewClass), NSIndexPath *indexPath);

@property(nonatomic, copy) __kindof UICollectionReusableView * (^footerViewForIndexPathBlock)(FlowCollectionView *collectionView, __kindof UICollectionReusableView *(^make)(Class viewClass), NSIndexPath *indexPath);

@property(nonatomic, copy) BOOL (^canMoveItemBlock)(FlowCollectionView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^moveItemBlock)(FlowCollectionView *collectionView, NSIndexPath *src, NSIndexPath *dest);

@property(nonatomic, copy) CGSize (^sizeForItemBlock)(FlowCollectionView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) UIEdgeInsets (^insetForSectionBlock)(FlowCollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) CGFloat (^minimumLineSpacingForSectionBlock)(FlowCollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) CGFloat (^minimumInteritemSpacingForSectionBlock)(FlowCollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) CGSize (^sizeForHeaderInSectionBlock)(FlowCollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) CGSize (^sizeForFooterInSectionBlock)(FlowCollectionView *collectionView, NSInteger section);

@property(nonatomic, copy) void (^didSelectItemBlock)(FlowCollectionView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^willDisplayCellBlock)(FlowCollectionView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^willDisplaySupplementaryViewBlock)(FlowCollectionView *collectionView, UICollectionReusableView *view, NSString *kind, NSIndexPath *indexPath);

- (instancetype)initWithFrame:(CGRect)frame;

- (void)registerCellClass:(Class)cellClass;

- (void)registerHeaderViewClass:(Class)viewClass;

- (void)registerFooterViewClass:(Class)viewClass;

@end

NS_ASSUME_NONNULL_END
