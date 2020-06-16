//
//  FlowListView.h
//  FlowListView
//
//  Created by v on 2020/6/13.
//  Copyright © 2020 lvv. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FlowListSupplementaryView.h"
#import "FlowListViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class FlowListViewDataSource;

@interface FlowListView : UICollectionView

@property(nonatomic, strong) FlowListViewDataSource *dataSourceProvider;

- (instancetype)initWithFrame:(CGRect)frame;

- (void)registerCellClass:(Class)cellClass;

- (void)registerHeaderViewClass:(Class)viewClass;

- (void)registerFooterViewClass:(Class)viewClass;

@end

#pragma mark - FlowListViewDataSource

@interface FlowListViewDataSource : NSObject

@property(nonatomic, copy) NSInteger (^numberOfSectionsBlock)(FlowListView *collectionView);

@property(nonatomic, copy) NSInteger (^numberOfItemsInSectionBlock)(FlowListView *collectionView);

@property(nonatomic, copy) __kindof UICollectionViewCell * (^cellForIndexPathBlock)(FlowListView *collectionView, __kindof UICollectionViewCell *(^make)(Class cellClass), NSIndexPath *indexPath);

@property(nonatomic, copy) __kindof UICollectionReusableView * (^headerViewForIndexPathBlock)(FlowListView *collectionView, __kindof UICollectionReusableView *(^make)(Class viewClass), NSIndexPath *indexPath);

@property(nonatomic, copy) __kindof UICollectionReusableView * (^footerViewForIndexPathBlock)(FlowListView *collectionView, __kindof UICollectionReusableView *(^make)(Class viewClass), NSIndexPath *indexPath);

@property(nonatomic, copy) BOOL (^canMoveItemBlock)(FlowListView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^moveItemBlock)(FlowListView *collectionView, NSIndexPath *src, NSIndexPath *dest);

@property(nonatomic, copy) CGSize (^sizeForItemBlock)(FlowListView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) UIEdgeInsets (^insetForSectionBlock)(FlowListView *collectionView, NSInteger section);

@property(nonatomic, copy) CGFloat (^minimumLineSpacingForSectionBlock)(FlowListView *collectionView, NSInteger section);

@property(nonatomic, copy) CGFloat (^minimumInteritemSpacingForSectionBlock)(FlowListView *collectionView, NSInteger section);

@property(nonatomic, copy) CGSize (^sizeForHeaderInSectionBlock)(FlowListView *collectionView, NSInteger section);

@property(nonatomic, copy) CGSize (^sizeForFooterInSectionBlock)(FlowListView *collectionView, NSInteger section);

@property(nonatomic, copy) void (^didSelectItemBlock)(FlowListView *collectionView, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^willDisplayCellBlock)(FlowListView *collectionView, UICollectionViewCell *cell, NSIndexPath *indexPath);

@property(nonatomic, copy) void (^willDisplaySupplementaryViewBlock)(FlowListView *collectionView, UICollectionReusableView *view, NSString *kind, NSIndexPath *indexPath);

@end

NS_ASSUME_NONNULL_END
